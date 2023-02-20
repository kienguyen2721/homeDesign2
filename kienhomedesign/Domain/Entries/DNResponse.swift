//
//  DNResponse.swift
//  baseapp
//
//  Created by Alex on 05/01/2022.
//

import Foundation
import SwiftyJSON
import ObjectMapper

class DNResponse<T: Mappable>: NSObject, Mappable {
    var error: String = "Unknow"
    var error_message: String = "Unknow"
    var data: [T]?
    var object: T?
    
    override init() {
        super.init()
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        error <- map["error"]
        error_message <- map["error_message"]
        data <- map["data"]
        object <- map["data"]
    }
}
