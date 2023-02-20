//
//  Home.swift
//  kienhomedesign
//
//  Created by Nguyễn Trung Kiên on 09/02/2023.
//

import Foundation
import ObjectMapper

public class  Home: NSObject, Mappable {
    var result: String = ""
    var isSellected: Bool = true
    
    
    convenience init(result: String,isSellected: Bool) {
        self.init()
        self.result = result
        self.isSellected = isSellected
    }
    

    required public convenience init?(map: Map) {
        self.init()
    }

    public func mapping(map: Map) {
        result <- map["result"]
        
    }
}

extension Home {
    
    func getFullPath() -> String {
        
        // Nếu có http:// thì trả về full path,
        if isValidHttp() {
            return self.result
        } else {
            // Nếu không có http:// thì cần nối domain + path
            return K_API_BASE_URL + result
        }
    }
    
    func isValidHttp() -> Bool {
        let isValid = self.result.contains("http://")
        log.debug(" Path có http:// hay không: \(isValid)")
        return isValid
    }
    
}
