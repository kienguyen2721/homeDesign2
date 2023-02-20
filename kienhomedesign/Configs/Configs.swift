//
//  Configs.swift
//  mvcsample
//
//  Created by Nguyen Dinh Dong on 25/11/2022.
//

import Foundation

/*
  - Mọi người chỉ cần gán các keys vào đây thôi.
  - File Managers/LibsManager.swift thì không cần làm gì thêm, nếu cần thiết thì mới vào viết thêm
 **/

// MARK: App & IAP
let K_APP_ID: String = ""
let K_APPLE_SECRET: String = ""

/*
 - Mặc định sẽ có những gói IAP này, cái nào cần thì thêm vào, k được xoá các key.
 - LibManagers.swift sẽ tự động xác định key nào có giá trị thì mới sử dụng để verify IAP
  **/

// Subscription - Thuê bao
// Các gói bình thường mà mình sẽ bán
let K_PRODUCT_WEEKLY: String = ""
let K_PRODUCT_MONTHLY: String = ""
let K_PRODUCT_YEARLY: String = ""

// Khi ứng dụng có màn flash sale thì thêm các gói sale vào đây
let K_PRODUCT_SALE_WEEKLY: String = ""
let K_PRODUCT_SALE_MONTHLY: String = ""
let K_PRODUCT_SALE_YEARLY: String = ""

// Consumable - Hết hạn, ví dụ giống như mua gem
let K_PRODUCT_100_GEM: String = "100.gem.pack" // Cho phép user mua 100 gem để mở khoá tính năng

// Trong AppStore connect vào In App Purchase -> non-comsumable ( Giao dịch mua không hết hạn)
let K_PRODUCT_LIFE_TIME: String = "lifetime.pack" // Cho phép user mở khoá toàn bộ tính năng


/*
 - Cần bổ xung một vài thông tin cho ứng dụng để share cũng như làm tính năng Contact us trong Settings
 **/

let K_TERM: String = ""
let K_POLICY: String = ""

let K_EMAIL_SUPPORT: String = ""
let K_LINK_APP: String = "https://itunes.apple.com/us/app/id\(K_APP_ID)"

/*
 - Bây h chúng ta không cần cài đặt tên app bằng tay nữa. Nó sẽ tự động lấy theo DisplayName
 **/
//let K_APP_NAME: String = UIApplication().displayName ?? "App"
//let K_APP_VERSION: String = UIApplication().version ?? "1.0.0"
// MARK: Trial
/*
 - Số lần dùng thử ứng dụng
 - Hãy thay đổi số lần dùng thử ứng dụng nếu cần
 **/
let K_LIMIT_TRIAL: Int = 1

// MARK: API & Decode
/*
  - API và Key mã hoá được khai báo dưới đây
 **/
let K_API_DECODE: String = "K1k2hH2uZF96ik5n"
let K_API_BASE_URL: String = "http://interiorapi.breakerai.com"

// MARK: - Analytics

/*
 - Xin Hiếu hoặc Đông cấp key AppMetrica trước khi publish app ( đưa app lên AppStore)
 - Key dưới đây chỉ để THỬ NGHIỆM
 - Test Key: 39f7835b-8a1b-432a-8a14-8403d4b6508e
 **/

let K_APP_METRICA: String = "39f7835b-8a1b-432a-8a14-8403d4b6508e"


// MARK: - Realm
/// Default schemaVersion bằng 1, khi cập nhật app mà chúng ta cần
/// thêm 1 thuộc tính cho Realm Model thì phải nâng schemaVersion lên

let K_SchemaVersion: UInt64 = 3 // Nếu thay đổi thì thay 1 -> 2, làm tương tự cho các version sau
