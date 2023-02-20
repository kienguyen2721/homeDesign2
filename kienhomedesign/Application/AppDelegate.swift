//
//  AppDelegate.swift
//  mvcsample
//
//  Created by Nguyen Dinh Dong on 25/11/2022.
//

//                        _oo0oo_
//                       o8888888o
//                       88" . "88
//                       (| -_- |)
//                       0\  =  /0
//                     ___/`---'\___
//                   .' \|     |// '.
//                  / \|||  :  |||// \
//                 / _||||| -:- |||||- \
//                |   | \\  -  /// |   |
//                | \_|  ''\---/''  |_/ |
//                \  .-\__  '-'  ___/-. /
//              ___'. .'  /--.--\  `. .'___
//           ."" '<  `.___\_<|>_/___.' >' "".
//          | | :  `- \`.;`\ _ /`;.`/ - ` : | |
//          \  \ `_.   \_ __\ /__ _/   .-` /  /
//      =====`-.____`.___ \_____/___.-`___.-'=====
//                        `=---='
// Đức phật nơi đây phù hộ code con chạy không Bug. Nam mô a di đà Phật

import UIKit

internal let appDelegate = UIApplication.shared.delegate as! AppDelegate

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var orientationLock = UIInterfaceOrientationMask.portrait

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Cấu hình cho các thư viện bên thứ 3
        let libsManager = LibsManager.shared
        libsManager.setupLibs()
        
        AppManager.shared.start()

        return true
    }
    
    // Hàm này sẽ chạy khi ứng dụng ở BackgroundMode -> ForegroundMode
    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return orientationLock
    }
}
