//
//  RestAPI.swift
//  mvcsample
//
//  Created by Nguyen Dinh Dong on 25/11/2022.
//

import Foundation
import ObjectMapper
import SwiftyJSON
import UIKit

class RestAPI: NSObject {
    // Singleton
    static let shared = RestAPI()

    
    func getHome(image: UIImage,room: String,style: String,complete: @escaping (Home?) -> Void) {
        getResult(apiKey: K_API_DECODE, target: .detectHomeDesign(image: image, room: room, style: style), objectType: DNResponse<Home>.self) { result in
            if let arr = result.object {
                log.debug("result")
                complete(arr)
            }else {
                complete(nil)
            }
        } failureHandler: {
            complete(nil)
        }

    }

}


private extension RestAPI {
    /// Hàm call api với API có mã hoá
    func getResult<T: Mappable>(apiKey: String,
                                target: Target,
                                objectType: T.Type,
                                completionHandler: @escaping (T) -> Void,
                                failureHandler: @escaping () -> Void)
    {
        provider.request(target) { result in
            do {
                let response = try result.get()
                let j = try response.mapJSON()
                log.debug(j)
                if let message = j as? String {
                    let decryptData = CryptoUtil.decrypt(key: apiKey,
                                                         message: message)
                    guard let data = decryptData else {
                        failureHandler()
                        return
                    }
                    let json = try JSON(data: data)
                    log.debug("\n===START:\(target.path)===\n\(json)\n=====END========", context: nil)
                    guard let targetObject = T(JSON: json.dictionaryObject!) else { return }
                    completionHandler(targetObject)
                } else {
                    failureHandler()
                }
            } catch {
                failureHandler()
            }
        }
    }

    /// Hàm call api không có mã hoá
    func getResult<T: Mappable>(target: Target,
                                objectType: T.Type,
                                completionHandler: @escaping (T) -> Void,
                                failureHandler: @escaping () -> Void)
    {
        provider.request(target) { result in
            do {
                let response = try result.get()

                let json = try JSON(data: response.data)
                log.debug("\n===START:\(target.path)===\n\(json)\n=====END========", context: nil)
                guard let dic = json.dictionaryObject else { failureHandler(); return }
                guard let targetObject = T(JSON: dic) else { failureHandler(); return }
                completionHandler(targetObject)
            } catch {
                failureHandler()
            }
        }
    }

    // Example: https://jsonplaceholder.typicode.com/todos
    func getArray<T: Mappable>(target: Target,
                               objectType: T.Type,
                               completionHandler: @escaping ([T]) -> Void,
                               failureHandler: @escaping () -> Void) {
        provider.request(target) { result in
            do {
                let response = try result.get()
                let json = try JSON(data: response.data)
                log.debug("\n===START:\(target.path)===\n\(json)\n=====END========", context: nil)
                let jsonArray = json.arrayValue
                let result = jsonArray.map( { T.init(JSON: $0.dictionaryObject!) })
                completionHandler(result.compactMap({$0}))
            } catch {
                failureHandler()
            }
        }
    }
}
