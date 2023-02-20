//
//  AppMetricaManager.swift
//  mvcsample
//
//  Created by Nguyen Dinh Dong on 25/11/2022.
//

import Foundation
import YandexMobileMetrica

class AppMetricaManager: NSObject {
    class func initializingSDK() {
        // Initializing the AppMetrica SDK.
        #if DEBUG

        #else
        let configuration = YMMYandexMetricaConfiguration(apiKey: K_APP_METRICA)
        YMMYandexMetrica.activate(with: configuration!)
        #endif
    }
}
