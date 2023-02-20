//
//  DNFileManager.swift
//  mvcsample
//
//  Created by dongnguyen on 18/12/2022.
//

import FCFileManager
import Foundation

class DNFileManager: NSObject {
    static let shared = DNFileManager()

    /// Hàm này lưu image vào document dir và trả về dường dẫn ảnh
    /// Output trả về last  path của ảnh: ..document_dir..../test.jpg
    func saveImage(image: UIImage) -> String? {
        let imageName = String.random(ofLength: 22) + ".jpg"
        guard let path = FCFileManager.pathForDocumentsDirectory(withPath: imageName) else { return nil }
        guard let fileURL = FCFileManager.urlForItem(atPath: path) else { return nil }
        guard let data = image.jpegData(compressionQuality: 1) else { return nil }
        DispatchQueue.global().async {
            if !FileManager.default.fileExists(atPath: fileURL.path) {
                do {
                    try data.write(to: fileURL)
                    print("Image Added Successfully")
                } catch let e {
                    print("Catch error: \(e)")
                }
            } else {
                print("Image Not Added")
            }
        }
        return imageName
    }

    /// Hàm hỗ trợ lấy image URL từ document dir. Sau đó dử dụng SDWebImage để load ảnh
    func getImageURL(lastComponentPath path: String) -> URL? {
        guard let path = FCFileManager.pathForDocumentsDirectory(withPath: path) else { return nil }
        return FCFileManager.urlForItem(atPath: path)
    }
}
