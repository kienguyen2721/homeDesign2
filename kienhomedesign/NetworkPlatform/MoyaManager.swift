//
//  MoyaManager.swift
//  mvcsample
//
//  Created by Nguyen Dinh Dong on 25/11/2022.
//

import Foundation
import Moya

let provider = MoyaProvider<Target>(plugins: [NetworkLoggerPlugin(configuration: .init(formatter: .init(responseData: JSONResponseDataFormatter)))])

enum Target {
    // Sample
    
    case detectHomeDesign(image: UIImage,room: String,style: String)
    
    
}

extension Target: TargetType {
    var baseURL: URL {
        return URL(string: K_API_BASE_URL)!
    }

    var path: String {
        return "/api/generateimage"
    }
    var method: Moya.Method {
        return .post
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        return .uploadMultipart(multipartBody!)
    }
    var headers: [String: String]? {
          
                return ["Content-type" : "application/json"]
            
        }
    var parameters: [String: Any]? {
        return nil
    }

    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.queryString
    }

    // put files in MultipartFormData Arry
    var multipartBody: [Moya.MultipartFormData]? {
        switch self {
    
        case .detectHomeDesign(let image,let room,let style):
            let imageName = UUID().uuidString + ".jpg"
            let mimeType: String = "image/jpg"
            let imageData = image.jpegData(compressionQuality: 0.8)!
            let imageProvider = Moya.MultipartFormData(provider: .data(imageData),
                                                       name: "image",
                                                       fileName: imageName,
                                                       mimeType: mimeType)
            let roomData = String(room).data(using: .utf8)!
                        let roomDataProvider = MultipartFormData(provider: .data(roomData),
                                                                 name: "room")
            let styleData = String(style).data(using: .utf8)!
                        let styleDataProvider = MultipartFormData(provider: .data(styleData),
                                                                 name: "style")
            
            return [imageProvider,roomDataProvider,styleDataProvider]
            
           
            default: return nil
        }
    }

    var localLocation: URL {
        return assetDir
    }

    var downloadDestination: DownloadDestination {
        return { _, _ in (self.localLocation, .removePreviousFile) }
    }
}

private func JSONResponseDataFormatter(data: Data) -> String {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return String(data: prettyData, encoding: .utf8) ?? String(data: data, encoding: .utf8) ?? ""
    } catch {
        return String(data: data, encoding: .utf8) ?? ""
    }
}

private extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}

private let assetDir: URL = {
    let directoryURLs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return directoryURLs.first ?? URL(fileURLWithPath: NSTemporaryDirectory())
}()

public func url(_ route: TargetType) -> String {
    return route.baseURL.appendingPathComponent(route.path).absoluteString
}

// MARK: - Response Handlers
extension Moya.Response {
    func mapNSArray() throws -> NSArray {
        let any = try self.mapJSON()
        guard let array = any as? NSArray else {
            throw MoyaError.jsonMapping(self)
        }
        return array
    }
}

public func convertImageToBase64String(image: UIImage) -> String {
    let strBase64 = image.pngData()?.base64EncodedString()
    return strBase64!
}
