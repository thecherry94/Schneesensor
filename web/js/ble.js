const bleNusServiceUUID  = '6e400001-b5a3-f393-e0a9-e50e24dcca9e';
const bleNusCharRXUUID   = '6e400002-b5a3-f393-e0a9-e50e24dcca9e';
const bleNusCharTXUUID   = '6e400003-b5a3-f393-e0a9-e50e24dcca9e';
const MTU = 20;


var m_ble_device;
var m_nus_service;
var m_rx_char;
var m_tx_char;
var m_connected = false;
var m_continuous = false;

var m_array_buf = new ArrayBuffer(256);
var m_data_buf = new DataView(m_array_buf, 0);
var m_data_offset = 0;

var m_active_content_id = "";



//var m_chart;
var m_ctx_air_temperature;
var m_ctx_air_pressure;
var m_ctx_air_humidity;

var m_chart_air_temperature;
var m_chart_air_pressure;
var m_chart_air_humidity;


function toggle_connection() {
    var btn_cont = document.getElementById("btn-cont-toggle-continuous");
    btn_cont.innerHTML = "Live Datenaufzeichnung starten";

    if (m_connected) {
        disconnect();
        
    } else {        
        connect();
    }   
}


function connect() {
    if (!navigator.bluetooth) {
        console.log("WebBluetooth API is not available.\r\n" + 
        "Please make sure the Web Bluetooth flag is enabled.");       
    }

    console.log("Requesting bluetooth device...");

    navigator.bluetooth.requestDevice({
        optionalServices: [bleNusServiceUUID],
        acceptAllDevices: true
    })
    .then(device => {
        ui_set_conn_state(2);
        m_ble_device = device;
        console.log("Found: " + device.name);
        console.log("Connecting to GATT Server...");
        m_ble_device.addEventListener('gattserverdisconnected', on_disconnected);
        return device.gatt.connect();
    })
    .then(server => {
        console.log("Locate NUS service");
        return server.getPrimaryService(bleNusServiceUUID);
    })
    .then(service => {
        m_nus_service = service;
        console.log("Found NUS service: " + service.uuid);
    })
    .then(() => {
        console.log("Locate RX characteristic")
        return m_nus_service.getCharacteristic(bleNusCharRXUUID);
    })
    .then(char => {
        m_rx_char = char;
        console.log("Found RX characteristic");
    })
    .then(() => {
        console.log("Locate TX characteristic");
        return m_nus_service.getCharacteristic(bleNusCharTXUUID);
    })
    .then(char => {
        m_tx_char = char;
        console.log("Found TX characteristic");
    })
    .then(() => {
        console.log("Enable notifications");
        return m_tx_char.startNotifications();
    })
    .then(() => {
        console.log("Notifications started");
        m_tx_char.addEventListener('characteristicvaluechanged', handle_notifications);
        m_connected = true;
        ui_set_conn_state(m_connected);
    })

    return m_connected;
}


function disconnect() {
    if (!m_ble_device) {
        console.log('No Bluetooth Device connected...');
        return;
    }
    console.log('Disconnecting from Bluetooth Device...');
    if (m_ble_device.gatt.connected) {
        m_ble_device.gatt.disconnect();
        m_connected = false;
        //setConnButtonState(false);
        console.log('Bluetooth Device connected: ' + m_ble_device.gatt.connected);
    } else {
        console.log('> Bluetooth Device is already disconnected');
    }
    ui_set_conn_state(m_connected);
}


function on_disconnected() {

}



function handle_notifications(ev) {
    console.log("notification");
    var value = ev.target.value;
    
    for (let i = 0; i < value.byteLength; i++) {
        var idx = i + m_data_offset;
        m_data_buf.setUint8(idx, value.getUint8(i));      

        if (i > 2) {
            if (m_data_buf.getUint8(idx-1) == 0x0D && m_data_buf.getUint8(idx) == 0x0A) {
                parse_data_packages(m_data_buf);

                m_array_buf = new ArrayBuffer(256);
                m_data_buf = new DataView(m_array_buf);
                m_data_offset = 0;
                return;
            }
        }
    }

    m_data_offset += value.byteLength;
} 

function nus_send_str(s) {
    if (m_ble_device && m_ble_device.gatt.connected) {
        console.log("send: " + s);
        var val_arr = new Uint8Array(s.length);
        for (var i = 0; i < s.length; i++) {
            var val = s[i].charCodeAt(0);
            val_arr[i] = val;
        }
        send_next_chunk(val_arr);
    } else {
        console.log("Not connectd to device yet");
    }
}


function send_next_chunk(a) {
    var chunk = a.slice(0, MTU);
    m_rx_char.writeValue(chunk).then(() => {
        if (a.length > MTU) {
            send_next_chunk(a.slice(MTU));
        }
    });
}


function parse_data_packages(data) {
    var offset = 0;
    var len = 0;
    for (let i = 0; i < data.byteLength; i++) {
        if (data.getUint8(i) == atoh(';')) {
            len = i - offset - 1;
            on_data_package_received(new DataView(data.buffer, offset), len);
            offset = i + 1;
        }
    }
}


function on_data_package_received(data, len) {
    if (data.getUint8(0) == atoh('c')) {
 
        var temp = data.getInt16(1, 3, true);
        var pres = data.getUint32(3, 7, true);
        var humi = data.getUint32(7, 11, true);

        var temperature = temp / 100.0;
        var pressure = pres / 100.0;
        var humidity = humi / 1000.0;

        console.log("T: " + temperature + " degC | P: " + pressure + " hPa + | H: " + humidity + " %rH");

        var time = new Date();
        var label = time.getHours() + ":" + time.getMinutes() + ":" + time.getSeconds();

        chart_add_data(m_chart_air_temperature, label, temperature);
        chart_add_data(m_chart_air_pressure, label, pressure);
        chart_add_data(m_chart_air_humidity, label, humidity);
    }
}


function atoh(str) {
    var arr1 = [];
    for (var n = 0, l = str.length; n < l; n ++) {
        var hex = Number(str.charCodeAt(n));
        arr1.push(hex);
    }
    return arr1.join('');
}

function u8toi(arr) {
    let buffer = Buffer.from(arr);
    return buffer.readUIntBE(0, arr.length);
}


function toggle_continuous() {
    if (m_connected) {
        nus_send_str("c!!1;\r\n");
        m_continuous = !m_continuous;
    }

    document.getElementById("toggle-continuous").innerHTML = "Live Datenaufzeichnung " + (m_continuous ? "stoppen" : "starten");
}


function ui_set_conn_state(state) {
    var txt_con_status = document.getElementById("nb-txt-con-status");
    var btn_con = document.getElementById("nb-btn-toggle-connection");

    if (state == 2) {
        txt_con_status.innerHTML = "Verbinden...";
        txt_con_status.style.color = "rgb(204,204,0)";

        btn_con.innerHTML = "Verbinden...";
        btn_con.classList.remove("uk-button-danger");
        btn_con.classList.add("uk-button-primary"); 
    }
    else if (state) {
        txt_con_status.innerHTML = "Verbunden";
        txt_con_status.style.color = "rgb(34,139,34)";

        btn_con.innerHTML = "Verbindung trennen";
        btn_con.classList.remove("uk-button-primary");
        btn_con.classList.add("uk-button-danger");
    } else {
        txt_con_status.innerHTML = "Nicht verbunden";
        txt_con_status.style.color = "rgb(255, 0, 0)";

        btn_con.innerHTML = "Verbinden";
        btn_con.classList.remove("uk-button-danger");
        btn_con.classList.add("uk-button-primary");      
    }
}


function switch_content(id) {
    var content = document.getElementById(id);
    if (content == null)
        return;

    fade(document.getElementById(m_active_content_id));
    unfade(content);
    m_active_content_id = id;

    UIkit.offcanvas("#navmenu").hide();
}


function on_load() {
    m_active_content_id = "content-home";

    m_ctx_air_temperature = document.getElementById("chart-air-temperature").getContext("2d");
    m_ctx_air_pressure = document.getElementById("chart-air-pressure").getContext("2d");
    m_ctx_air_humidity = document.getElementById("chart-air-humidity").getContext("2d");

    m_chart_air_temperature = create_simple_line_chart(m_ctx_air_temperature, "Lufttemperatur [degC]", 'rgb(255, 0, 0)');
    m_chart_air_pressure = create_simple_line_chart(m_ctx_air_pressure, "Luftdruck [hPa]", 'rgb(0, 255, 0)');
    m_chart_air_humidity = create_simple_line_chart(m_ctx_air_humidity, "Luftfeuchtigkeit [%rH]", 'rgb(0, 0, 255)');

    document.getElementsByClassName("content").forEach(element => {
        element.style.opacity = 0.1;
        element.style.filter = 'alpha(opacity=' + 0.1 * 100 + ")";
    });

    document.getElementsByClassName("content-start")[0].opacity = 1;
    document.getElementsByClassName("content-start")[0].filter = 'alpha(opacity=' + 100 + ")";

    /*
    m_chart = new Chart(m_ctx, {
        type: 'line',
        data: {
            labels: [],
            datasets: [
                {
                    label: "Lufttemperatur (degC)",
                    yAxisID: 'a',
                    data: [],
                    backgroundColor: 'rgb(255, 0, 0)'
                },
                {
                    label: "Luftdruck (hPa)",
                    yAxisID: 'b',
                    data: [],
                    backgroundColor: 'rgb(0, 255, 0)'
                },
                {
                    label: "Luftfeuchte (%rH)",
                    yAxisID: 'c',
                    data: [],
                    backgroundColor: 'rgb(0, 0, 255)'
                }
            ]
        },
        options: {
            scales: {
                yAxes: [{
                    id: 'a',
                    type: 'linear',
                    position: 'left' 
                }, {
                    id: 'b',
                    type: 'linear',
                    position: 'left'
                }, {
                    id: 'c',
                    type: 'linear',
                    position: 'left'
                }]
            }
        }
    });
    */
}

function create_simple_line_chart(_ctx, _label, _line_color) {
    var chart = new Chart(_ctx, {
        type: 'line',
        data: {
            labels: [],
            datasets: [
                {
                    label: _label,
                    data: [],
                    backgroundColor: _line_color
                }
            ]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false
        }
    });

    return chart;
}

function chart_add_data(chart, label, data) {
    chart.data.labels.push(label);

    if(chart.data.datasets.length > 1)
        for (var i = 0; i < chart.data.datasets.length; i++) 
            chart.data.datasets[i].data.push(data[i]);
    else if (data.length == null)
        chart.data.datasets[0].data.push(data);
    else
        console.error("chart_add_data: Parameter mismatch");

    chart.update();
}

function chart_remove_data(chart) {
    chart.data.labels.pop();
    chart.data.datasets.forEach(dataset => {
        dataset.data.pop();
    });
    chart.update();
}


function fade(element) {
    var op = 1;  // initial opacity
    var timer = setInterval(function () {
        if (op <= 0.05){
            clearInterval(timer);
            element.hidden = true;
        }
        element.style.opacity = op;
        element.style.filter = 'alpha(opacity=' + op * 100 + ")";
        op -= op * 0.05;
    }, 25);
}


function unfade(element) {
    var op = 0.05;  // initial opacity
    element.hidden = false;
    var timer = setInterval(function () {
        if (op >= 1){
            clearInterval(timer);
        }
        element.style.opacity = op;
        element.style.filter = 'alpha(opacity=' + op * 100 + ")";
        op += op * 0.05;
    }, 25);
}


function display_not_impl_notification() {
    UIkit.notification({
        message: "Feature noch nicht implementiert!",
        status: "danger",
        pos: "top-center",
        timeout: 5000
    });
}