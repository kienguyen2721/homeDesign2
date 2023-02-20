//
//  Permission+Util.swift
//  mvcsample
//
//  Created by Nguyen Dinh Dong on 25/11/2022.
//

import Foundation
import Permission

typealias PUtilBlock<T> = (T) -> Void

class PermissionUtil: NSObject {
    
    /// Kiểm tra xem user có cấp quyền Photos không
    class func checkPhoto(completion: @escaping PUtilBlock<Bool>) {
        let permission: Permission = .photos
        permission.request { status in
            switch status {
            case .authorized: completion(true)
                print("authorized")
            case .denied: completion(false)
                print("denied")
            case .disabled: completion(false)
                print("disabled")
            case .notDetermined: completion(false)
                print("not determined")
            }
        }
    }
    
    
    /// Kiểm tra xem user có cấp quyền camera không
    class func checkCamera( completion: @escaping PUtilBlock<Bool>) {
        let permission: Permission = .camera
        permission.request { status in
            switch status {
            case .authorized: completion(true)
                print("authorized")
            case .denied: completion(false)
                print("denied")
            case .disabled: completion(false)
                print("disabled")
            case .notDetermined: completion(false)
                print("not determined")
            }
        }
    }
}
