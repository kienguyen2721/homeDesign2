//
//  Alias.swift
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

import Foundation

/*
 Một typealias cho phép chúng ta cung cấp một tên mới cho một loại dữ liệu hiện có. Sau khi một typealias được khai báo, nó có thể được sử dụng thay vì loại hiện có trong suốt chương trình. Typealias không tạo ra loại mới. Nó chỉ đơn giản là cung cấp một tên mới cho một loại hiện có. Mục đích chính của typealias là làm cho mã của chúng ta dễ đọc hơn và rõ ràng hơn trong ngữ cảnh cho sự hiểu biết của con người. Chúng ta cùng xem xét sự hữu dụng của nó trong các trường hợp sau đây.
 **/

/*
 // Semantic types
 typealias Kilograms = Double

 struct Package {
     var weight: Kilograms
 }
 **/

// typealias name = existing type

typealias BFComplete = () -> Void
typealias BFFailure = () -> Void
