//
//  HomeStyleModel.swift
//  kienhomedesign
//
//  Created by Nguyễn Trung Kiên on 10/02/2023.
//

import Foundation
class HomeStyleModel {
    var image: String = ""
    var name: String = ""
    var isTapped: Bool = false
    
    init(image: String,name: String,isTapped: Bool) {
        self.image = image
        self.name = name
        self.isTapped = isTapped
        
    }
}
