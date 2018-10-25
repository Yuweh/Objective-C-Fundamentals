//
//  TAccountManager.swift
//

2018-10-25 15:37:00.828754+0800 Tahoma Bee[411:70997] *** loadingView - TLoginViewController
*** Reachable via WiFi - WifiConnectionManager
*** checkGatewayConnectivity @WifiQRCodeViewController - didFind localGateways and gateway is nil & nil
*** didFind localGateways  - connectEPOSAndPairLocalGateway
*** randomToken j27lnpwofmbmh39620v6

import Foundation

extension TAccountManager {
    
    @objc public func connectLocal() {
        EPLocalConfigurator.getInstance().startLocalDiscover(with: self)
    }
    
    @objc func delayWithSeconds(_ seconds: Double, completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
    }

}

extension TAccountManager: EPLocalConfiguratorDelegate {
    
    @objc public func localConfiguratorIsBusy(_ configurator: EPLocalConfigurator!) {
        print("*** TAccountManager: EPLocalConfiguratorDelegate - localConfiguratorIsBusy")
    }
    
    @objc public func localConfigurator(_ configurator: EPLocalConfigurator!, didFind localGateways: [EPLocalGateway]!) {
        TWifi.checkGatewayConnectivity(atPhase: "WifiQRCodeViewController - didFind localGateways")
        let preferences = UserDefaults.standard
        let randomToken = WifiConnectionManager.randomTokenGenerator()
        for gateway in localGateways {
            //EPOSAgent.setEPOSAgentDelegate(self)
            if preferences.object(forKey: "\(gateway.name)-localMode") == nil {
                print("*** didFind localGateways  - connectEPOSAndPairLocalGateway")
                preferences.set(randomToken, forKey: "\(gateway.name)-localMode")
                print("*** randomToken \(randomToken)")
                EPOSAgent.connectEPOSAndPairLocalGateway(gateway,
                                                         withToken: randomToken,
                                                         initMask: AppInitMask.setup,
                                                         secureDatasource: WifiCertificate())
                preferences.synchronize()
                return
            }

            print("*** didFind localGateways  - connectEPOS")
            let savedToken = preferences.string(forKey: "\(gateway.name)-localMode")!
            EPOSAgent.connectEPOS(with: gateway,
                                  authToken: savedToken,
                                  initMask: AppInitMask.setup,
                                  secureDatasource: WifiCertificate())
            return
        }
    }
    
    @objc public func localConfigurator(_ configurator: EPLocalConfigurator!, didNotFindLocalGatewaysWithError error: Error!) {
         print("*** TAccountManager: EPLocalConfiguratorDelegate - didNotFindLocalGatewaysWithError")
    }
}



