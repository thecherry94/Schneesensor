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


var m_current_meas_series = null;

var m_map;


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
    m_connected = false;
    m_continuous = false;
    ui_set_conn_state(false);
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
    var cmd = data.getUint8(0);
    if (cmd == atoh('c')) {
 
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
    } else if (cmd == atoh('m')) {
        var air_temp = data.getInt16(1, 3, true) / 100.0;
        var air_pres = data.getUint32(3, 7, true) / 100.0;
        var air_humi = data.getUint32(7, 11, true) / 1000.0;

        var snow_temp = data.getInt16(11, 13, true);
        var snow_hard = data.getInt16(13, 15, true);
        var snow_mois = data.getInt16(15, 17, true);

        var dv = new DataView(data.buffer);

        var gps_pos = {
            latitude: dv.getFloat32(17, true),
            longitude: dv.getFloat32(21, true),
            valid: data.getUint8(25) == 1
        };

        if (m_current_meas_series != null) {
            var row = [
                air_temp,
                air_pres,
                air_humi,
                snow_temp,
                snow_hard,
                snow_mois,
                gps_pos.latitude,
                gps_pos.longitude,
                gps_pos.valid
            ];
            add_row_to_measurment_series(m_current_meas_series, row);
        }
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


function ui_btn_new_meas_series_clicked() {
    if (m_current_meas_series == null) {
        var name = prompt("Bitte geben Sie einen Namen für die neue Messreihe ein.");
        if (name == null)
            return;
        
        if (name.length < 3) {
            UIkit.notification({
                message: "Der Dateiname einer Messreihe muss mindestens 3 Zeichen beinhalten!",
                status: "danger",
                pos: "top-center",
                timeout: 3000
            });
        }

        // Add check if filename already exists in IndexedDB

        m_current_meas_series = create_new_measurement_series(name);
        m_current_meas_series.dataChangedEventHandler = current_measurement_series_updated_event_handler;
        document.getElementById("ui_txt_current_meas_series_name").innerHTML = name;
        document.getElementById("ui_txt_current_meas_series_date_created").innerHTML = m_current_meas_series.dateCreated;
        document.getElementById("ui_txt_current_meas_series_date_modified").innerHTML = m_current_meas_series.dateModified;

        var btn = document.getElementById("ui_btn_new_meas_series");
        btn.innerHTML = "Messreihe speichern und schließen";
        btn.onclick = ui_btn_close_meas_series_clicked;

        document.getElementById("ui_btn_take_single_measurement").disabled = false;
        document.getElementById("ui_inp_single_measurement_interval").disabled = false;
        document.getElementById("ui_inp_single_measurement_amount").disabled = false;

    } else {
        // Another measurement series is still open
        UIkit.notification({
            message: "Es ist bereits eine Messreihe geöffnet!",
            status: "danger",
            pos: "top-center",
            timeout: 5000
        });
    }
}


function ui_btn_close_meas_series_clicked() {
    if (!confirm("Möchten Sie die Messreihe wirklich speichern und schließen?"))
        return;
    
    UIkit.notification({
        message: "Das Speichern einer Messreihe ist noch nicht möglich!",
        status: "danger",
        pos: "top-center",
        timeout: 5000
    });

    if (!confirm("Das Speichern einer Messreihe ist noch nicht möglich!\nTrotzdem schließen (=löschen)?"))
        return;
    
    // TODO Save measurement series if requested

    // Clear everything
    m_current_meas_series = null;
    document.getElementById("tbl_current_meas_series").getElementsByTagName("tbody")[0].innerHTML = "";

    // Reset
    var btn = document.getElementById("ui_btn_new_meas_series");
    btn.innerHTML = "Neue Messreihe anlegen";
    document.getElementById("ui_txt_current_meas_series_name").innerHTML = "-";
    document.getElementById("ui_txt_current_meas_series_date_created").innerHTML = "-";
        document.getElementById("ui_txt_current_meas_series_date_modified").innerHTML = "-";
    btn.onclick = ui_btn_new_meas_series_clicked;

    document.getElementById("ui_btn_take_single_measurement").disabled = true;
        document.getElementById("ui_inp_single_measurement_interval").disabled = true;
        document.getElementById("ui_inp_single_measurement_amount").disabled = true;
}

function ui_btn_take_single_meas_clicked() {
    var cmd = "m }!;\r\n";

    nus_send_str(cmd);
}

function current_measurement_series_updated_event_handler(ev) {
    if (ev.type == "added") {
        var table = document.getElementById("tbl_current_meas_series");
        var row = table.insertRow(-1);
        var cell_air_temp = row.insertCell(0);
        var cell_air_pres = row.insertCell(1);
        var cell_air_humi = row.insertCell(2);
        var cell_snow_temp = row.insertCell(3);
        var cell_snow_hard = row.insertCell(4);
        var cell_snow_mois = row.insertCell(5);
        var cell_latitude = row.insertCell(6);
        var cell_longitude = row.insertCell(7);
        var cell_valid = row.insertCell(8);

        var idx = m_current_meas_series.data.length - 1;
        cell_air_temp.innerHTML = m_current_meas_series.data[idx][0];
        cell_air_pres.innerHTML = m_current_meas_series.data[idx][1];
        cell_air_humi.innerHTML = m_current_meas_series.data[idx][2];
        cell_snow_temp.innerHTML = m_current_meas_series.data[idx][3];
        cell_snow_hard.innerHTML = m_current_meas_series.data[idx][4];
        cell_snow_mois.innerHTML = m_current_meas_series.data[idx][5];
        cell_latitude.innerHTML = m_current_meas_series.data[idx][6];
        cell_longitude.innerHTML = m_current_meas_series.data[idx][7];
        cell_valid.innerHTML = m_current_meas_series.data[idx][8];
    }
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


function initMap() {
    maps_tab = document.getElementById("ui_tab_maps");
    maps_tab.addEventListener("beforeshow", function() {
        const hska = { lat: 49.025778933333335, lng: 8.624536266666667 };
        m_map = new google.maps.Map(document.getElementById("ui_map"), {
            zoom: 16,
            center: hska
        });
    });
}

function on_load() {
    m_active_content_id = "content-home";

    m_ctx_air_temperature = document.getElementById("chart-air-temperature").getContext("2d");
    m_ctx_air_pressure = document.getElementById("chart-air-pressure").getContext("2d");
    m_ctx_air_humidity = document.getElementById("chart-air-humidity").getContext("2d");

    m_chart_air_temperature = create_simple_line_chart(m_ctx_air_temperature, "Lufttemperatur [degC]", 'rgb(255, 0, 0)');
    m_chart_air_pressure = create_simple_line_chart(m_ctx_air_pressure, "Luftdruck [hPa]", 'rgb(0, 255, 0)');
    m_chart_air_humidity = create_simple_line_chart(m_ctx_air_humidity, "Luftfeuchtigkeit [%rH]", 'rgb(0, 0, 255)');

    initMap();

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

function create_new_measurement_series(_name) {
    if (_name.length < 3) 
        return;

    var series = {
        name: _name,
        dateCreated: new Date(),
        dateModified: new Date(),
        labels: [
            "Lufttemperatur [degC]", "Luftdruck [hPa]", "Luftfeuchtigkeit [%rH]",
            "Schneetemperatur [degC]", "Schneehärte [?]", "Schneefeuchtigkeit [?]",
            "Latitude", "Longitude", "Valid"
        ],
        data: [],
        dataChangedEventHandler: function(ev) {}
    };

    return series;
}

function add_row_to_measurment_series(series, row) {
    if (!Array.isArray(row))
        return;

    if (series.labels.length != row.length)
        return;
    
    series.dateModified = new Date();
    series.data.push(row);

    var ev = {
        type: 'added'
    };
    series.dataChangedEventHandler(ev);
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

function display_not_impl_notification() {
    UIkit.notification({
        message: "Feature noch nicht implementiert!",
        status: "danger",
        pos: "top-center",
        timeout: 5000
    });
}


function raw_gps_pos_to_coord(raw) {
    return {
        latitude: raw_gps_parse_value(raw.latitude),
        longitude: raw_gps_parse_value(raw.longitude),
        valid: raw.valid
    };
}

function raw_gps_parse_value(raw) {
    if (raw.scale == 0)
        return NaN;
    
    var degrees = raw.value / (raw.scale * 100);
    var minutes = raw.value % (raw.scale * 100);
    return degrees + minutes / (60.0 * raw.scale);
}