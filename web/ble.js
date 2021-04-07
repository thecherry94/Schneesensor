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

var m_data_buf = [];



//var m_chart;
var m_ctx_air_temperature;
var m_ctx_air_pressure;
var m_ctx_air_humidity;

var m_chart_air_temperature;
var m_chart_air_pressure;
var m_chart_air_humidity;


function toggle_connection() {
    if (m_connected) {
        disconnect();
    } else {
        connect();
    }

    // TODO: Visual output
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
        
    })
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
}


function on_disconnected() {

}



function handle_notifications(ev) {
    console.log("notification");
    var value = ev.target.value;
    
    for (let i = 0; i < value.byteLength; i++) {
        var c = value.getUint8(i);  
        m_data_buf.push(c);

        var len = m_data_buf.length;
        if (m_data_buf[len-2] == 0x0D && m_data_buf[len-1] == 0x0A) {
            on_data_package_received(m_data_buf);
            m_data_buf = [];
        }
    }
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


function on_data_package_received(data) {
    if (data[0] == atoh('c')) {

        var temp = new DataView(new Uint8Array(data.slice(1, 3).reverse()).buffer).getInt16();
        var pres = new DataView(new Uint8Array(data.slice(3, 7).reverse()).buffer).getUint32();
        var humi = new DataView(new Uint8Array(data.slice(7, 11).reverse()).buffer).getUint32();

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

    document.getElementById("continuous").innerHTML = "Live Datenaufzeichnung " + (m_continuous ? "stoppen" : "starten");
}


function on_load() {
    m_ctx_air_temperature = document.getElementById("chart-air-temperature").getContext("2d");
    m_ctx_air_pressure = document.getElementById("chart-air-pressure").getContext("2d");
    m_ctx_air_humidity = document.getElementById("chart-air-humidity").getContext("2d");

    m_chart_air_temperature = create_simple_line_chart(m_ctx_air_temperature, "Lufttemperature [degC]", 'rgb(255, 0, 0)');
    m_chart_air_pressure = create_simple_line_chart(m_ctx_air_pressure, "Luftdruck [hPa]", 'rgb(0, 255, 0)');
    m_chart_air_humidity = create_simple_line_chart(m_ctx_air_humidity, "Luftfeuchtigkeit [%rH]", 'rgb(0, 0, 255)');

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
    else if (data.length != null)
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