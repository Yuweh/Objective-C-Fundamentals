import Foundation

//set in SWIFT
 
@objc(TWifi) public class TWifi: CWifi {
    
    static func currentWifiMode() -> String {
        switch Wifi.init().wifiMode.rawValue {
        case 1:
            return "WifiModeUnknown"
        case 2:
            return "WifiModeInfrastructure"
        case 3:
            return "WifiModeAccesspoint"
        default:
            return "WifiModeUnknown"
        }
    }
    
    static func changeWifiMode(wifiMode: WifiMode) {
        /// Command to change the wifi mode. Returns
        /// Returns nil if the mode is unknown
        Wifi.command(forSetWifiMode: wifiMode)
    }
    
    static func setWifiInfraConfig(ssid: String, passphrase: String) {
        /// Command to send internet box's SSID & Password to the box.
        /// returns null if ssid or password are empty
        Wifi.commandForSetTargetInfraConfig(withSSID: ssid, password: passphrase)
    }
}


- - - - - - 
//with Objective-C
        NSLog(@"*** devicesInPlace: now placeToUse == nil");

    if (placeToUse == nil) {
        NSLog(@"*** devicesInPlace: now placeToUse == nil");
        return [TDeviceManager getInstance].getAllDevices;
    }

