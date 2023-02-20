//
//  HomesUseCase.swift
//  kienhomedesign
//
//  Created by Nguyễn Trung Kiên on 09/02/2023.
//

import Foundation
public protocol HomesUseCase {
    func getAll(image: UIImage,room: String,style: String,complete: @escaping (Home?) -> Void)
    func save(home: Home) -> Void
    func delete(home: Home) -> Void
    func findHome(with id: String, complete: @escaping (Home?) -> Void)
}

