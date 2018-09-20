//Determine Wifi Status
*******************************************************
//ref (NEHotspotConfig):
- https://dev.classmethod.jp/smartphone/nehotspotconfiguration/

//ref(NEHotspotHelper)
-


*******************************************************
//iOS11 and up: NEHotspotConfiguration




//iOS9 and later: NEHotspotHelper




*******************************************************
// Auto Connect to Wifi : only applies to iOS11, no need to enter SSID and password
//ref: http://www.coderzheaven.com/2018/05/05/autoconnect-to-wi-fi-in-ios/

*******************************************************
if (@available (iOS 11.0, *)) {
     
    NEHotspotConfiguration * configuration = 
                [[NEHotspotConfiguration alloc] initWithSSID: wifiSSID];
    configuration.joinOnce = YES;
     
    /* Alert the OS that the user wants to connect to the WiFi */
    [[NEHotspotConfigurationManager sharedManager] 
                      applyConfiguration: configuration 
                      completionHandler: ^ (NSError * _Nullable error) {
      if (nil == error) {
        DLog (@ "Is Connected!!");
      } else {
        DLog (@ "Error is:%@", error);
    }}];
     
}
*******************************************************



































