//
//  NetHomesUseCase.swift
//  kienhomedesign
//
//  Created by Nguyễn Trung Kiên on 09/02/2023.
//

import Foundation
final class NetHomesUseCase: HomesUseCase {
  
func save(home: Home) {
    // Không làm gì cả
}

func delete(home: Home) {
    // không làm gì cả
}
    func getAll(image: UIImage, room: String, style: String, complete: @escaping (Home?) -> Void) {
        RestAPI.shared.getHome(image: image, room: room, style: style, complete: complete)
    }

func findHome(with id: String, complete: @escaping (Home?) -> Void) {
    // Call api tìm kiếm
}
}
