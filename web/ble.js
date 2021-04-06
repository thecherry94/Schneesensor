const bleNusServiceUUID  = '6e400001-b5a3-f393-e0a9-e50e24dcca9e';
const bleNusCharRXUUID   = '6e400002-b5a3-f393-e0a9-e50e24dcca9e';
const bleNusCharTXUUID   = '6e400003-b5a3-f393-e0a9-e50e24dcca9e';
const MTU = 20;


var m_ble_device;
var m_nus_service;
var m_rx_char;
var m_tx_char;
var m_connected = false;



function toggle_connection() {
    if (m_connected) {
        disconnect();
    } else {
        m_connected();
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
    
    let str = "";
    for (let i = 0; i < value.byteLength; i++) {
        str += String.fromCharCode(value.getUint8(i));
    }
    console.log(str);
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