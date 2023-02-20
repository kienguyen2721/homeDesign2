//
//  DNPermission.swift
//  kienhomedesign
//
//  Created by Nguyễn Trung Kiên on 14/02/2023.
//

import Foundation

import Permission

typealias DNPermissionBlock<T> = (T) -> Void

class DNPermission: NSObject {
    class func checkPhoto(completion: @escaping DNPermissionBlock<Bool>) {
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
    
    class func checkCamera( completion: @escaping DNPermissionBlock<Bool>) {
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
