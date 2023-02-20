//
//  RealmRepository.swift
//  mvcsample
//
//  Created by dongnguyen on 18/12/2022.
//

import Foundation
import Realm
import RealmSwift

/*
 - Mục này ae không cần quan tâm
 - Cái này hỗ trợ CRUD cho các object realm
 **/

protocol AbstractRepository {
    associatedtype T
    func queryAll() -> [T]
    func query(with predicate: NSPredicate) -> [T]
    func save(entity: T) -> Void
    func delete(entity: T) -> Void
    func update(entity: T) -> Void
}

final class RealmRepository<T: RealmRepresentable>: AbstractRepository where T == T.RealmType.DomainType, T.RealmType: Object {
    private let configuration: Realm.Configuration
    private var serialQueue: DispatchQueue

    init(configuration: Realm.Configuration) {
        self.configuration = configuration
        let name = "com.barefeets.realm.platform.repository.serial.queue"
        self.serialQueue = DispatchQueue(label: name)
        print("File 📁 url: \(RLMRealmPathForFile("default.realm"))")
    }

    func queryAll() -> [T] {
        do {
            let realm = try Realm(configuration: configuration)
            let objects = realm.objects(T.RealmType.self)
            return Array(objects.map { $0.asDomain() })
        } catch let e {
            print("Realm catch error: \(e)")
            return []
        }
    }

    func query(with predicate: NSPredicate) -> [T] {
        do {
            let realm = try Realm(configuration: configuration)
            let objects = realm.objects(T.RealmType.self).filter(predicate)
            return Array(objects.map { $0.asDomain() })
        } catch let e {
            print("Realm catch error: \(e)")
            return []
        }
    }

    func save(entity: T) {
        serialQueue.async {
            do {
                let realm = try Realm(configuration: self.configuration)
                try realm.write {
                    realm.add(entity.asRealm(), update: .modified)
                }
            } catch let e {
                print("Realm catch error: \(e)")
            }
        }
    }

    func delete(entity: T) {
        serialQueue.async { [self] in
            do {
                let realm = try Realm(configuration: configuration)
                if let object = realm.object(ofType: T.RealmType.self, forPrimaryKey: entity.uid) {
                    try realm.write {
                        realm.delete(object)
                    }
                }
            } catch let e {
                print("Realm catch error: \(e)")
            }
        }
    }

    /// Upsert an Object
    /// An upsert either inserts or updates an object depending on whether the object already exists. Upserts require the data model to have a primary key.
    /// https://www.mongodb.com/docs/realm/sdk/swift/crud/update/
    func update(entity: T) {
        serialQueue.async { [self] in
            do {
                let realm = try Realm(configuration: configuration)
                if let _ = realm.object(ofType: T.RealmType.self, forPrimaryKey: entity.uid) {
                    try realm.write {
                        realm.add(entity.asRealm(), update: .modified)
                    }
                } else {
                    log.debug("Không thể tìm thấy đối tượng để cập nhật")
                }
            } catch let e {
                print("Realm catch error: \(e)")
            }
        }
    }
}
