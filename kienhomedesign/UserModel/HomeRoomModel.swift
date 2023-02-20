//
//  HomeRoomModel.swift
//  kienhomedesign
//
//  Created by Nguyễn Trung Kiên on 10/02/2023.
//

import Foundation

class HomeRoomModel {
    var image: String = ""
    var name: String = ""
    var isSellected: Bool = true
    
    init(image: String,name: String,isSellected: Bool) {
        self.image = image
        self.name = name
        self.isSellected = isSellected
    }
}
