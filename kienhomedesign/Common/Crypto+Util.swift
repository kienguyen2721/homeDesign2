//
//  Crypto+Util.swift
//  mvcsample
//
//  Created by Nguyen Dinh Dong on 25/11/2022.
//

import Foundation
import CryptoSwift

struct CryptoUtil {

    /**
     Giải mã  nội dung mã hoá từ phía server
     Decode Base64 theo thuật toán AES 16-bytes

     - Parameters:
        - key: Khoá chính để giải mã
        - message: Nội dung cần giải mã đã được encode base64

     - Returns: Optional Data đã được giải mã dùng để chuyển đổi sang JSON data
     */
    static func decrypt(key: String, message: String) -> Data? {
       // print("Message: \(message)")
        // 1. Tách 16 kí tự khỏi chuỗi message ban đầu
        // 16 chuỗi kí tự đầu tiên chính là mã IV
        let iv = message[0 ..< 16]

        // 2. Chuỗi kí tự còn lại là nội dung cần được giải mã
        let content = message.substring(fromIndex: 16)
        do {
            // 3. Tạo thực thể AES để chuẩn bị cho việc giải mã
            let aes = try AES.init(key: key, iv: iv, padding: .pkcs7)

            // 4.1 Chuyển đổi nội dung cần giải mã sang Data
            if let encryptedData = Data(base64Encoded: content) {

                // 4.1.1 Giải mã nội dung sử dụng aes.decrypt
                let decryptBytes = try aes.decrypt(encryptedData.convertToBytes)

                // 4.1.2 Chuyển đổi chuỗi bytes thành data hoàn chỉnh
                let decryptedData = Data(decryptBytes)

                // 4.1.3. Trả về data đã được giải mã
                return decryptedData

            // 4.2 Nếu trường hợp lỗi trả về nil
            } else {
                return nil
            }
        } catch (let e) {
            // Lỗi khi giải mã, có thể do sai khoá chính
            print("AFCrypto \(e)")
        }
        // Trường hợp không thể giải mã
        return nil
    }

}

// Phần mở rộng cho String dùng để subString, chỉ có thể sử dụng extension này bên trong file
fileprivate extension String {

    var length: Int {
        return count
    }

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}


extension Data {


  public var convertToBytes: Array<UInt8> {
    Array(self)
  }

  public func convertToHexString() -> String {
    self.convertToBytes.toHexString()
  }
}
