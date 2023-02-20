//
//  RMAvatar.swift
//  mvcsample
//
//  Created by dongnguyen on 20/12/2022.
//

import Foundation
import RealmSwift
import Realm

//class RMAvatar: Object {
//    @Persisted(primaryKey: true) var uid: String = UUID().uuidString
//    @Persisted var token: String = ""
//    @Persisted var requestID: Int = 0
//    @Persisted var name: String = "@Generate for you"
//    @Persisted var avatar: String = ""
//    @Persisted var gender: String = ""
//    @Persisted var images: List<String> = .init()
//    @Persisted var date = Date()
//    
//}

//extension RMAvatar: DomainConvertibleType {
//    func asDomain() -> Avatar {
//        let avatar = Avatar()
//        avatar.uid = self.uid
//        avatar.token = self.token
//        avatar.requestID = self.requestID
//        avatar.name = self.name
//        avatar.avatar = self.avatar
//        avatar.gender = self.gender
//        avatar.images = Array(self.images.elements)
//        avatar.date = self.date
//        return avatar
//    }
//}
//
//extension Avatar: RealmRepresentable {
//    func asRealm() -> RMAvatar {
//        let avatar = RMAvatar()
//        avatar.uid = self.uid
//        avatar.token = self.token
//        avatar.requestID = self.requestID
//        avatar.name = self.name
//        avatar.avatar = self.avatar
//        avatar.gender = self.gender
//        avatar.images.append(objectsIn: self.images)
//        avatar.date = self.date
//        return avatar
//    }
//}
