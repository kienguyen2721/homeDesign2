////
////  RMRock.swift
////  mvcsample
////
////  Created by dongnguyen on 19/12/2022.
////
//
//import Foundation
//import RealmSwift
//import Realm
//
//class RMRock: Object {
//    @Persisted(primaryKey: true) var uid: String = UUID().uuidString
//    @Persisted var name = ""
//    @Persisted var desc = ""
//}
//
//extension RMRock: DomainConvertibleType {
//    func asDomain() -> Rock {
//        let rock = Rock()
//        rock.uid = uid
//        rock.name = name
//        rock.desc = desc
//        return rock
//    }
//}
//
//extension Rock: RealmRepresentable {
//    func asRealm() -> RMRock {
//        let rock = RMRock()
//        rock.uid = uid
//        rock.name = name
//        rock.desc = desc
//        return rock
//    }
//}
