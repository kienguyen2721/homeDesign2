////
////  RMUseCaseProvider.swift
////  mvcsample
////
////  Created by dongnguyen on 18/12/2022.
////
//
//import Foundation
//import Realm
//import RealmSwift
//
///*
// // When you open the realm, specify that the schema
// // is now using a newer version.
// let config = Realm.Configuration(
//     schemaVersion: 2)
// // Use this configuration when opening realms
// Realm.Configuration.defaultConfiguration = config
// let realm = try! Realm()
// **/
//
//final class RMUseCaseProvider: UseCaseProvider {
//    private let configuration: Realm.Configuration
//    public init(configuration: Realm.Configuration = Realm.Configuration(schemaVersion: K_SchemaVersion)) {
//        self.configuration = configuration
//    }
//
//    func makeTodosUseCase() -> TodosUseCase {
//        let respository = RealmRepository<Todo>.init(configuration: configuration)
//        return RMTodoUseCase(repository: respository)
//    }
//    
//    func makeRocksUseCase() -> RocksUseCase {
//        let respository = RealmRepository<Rock>.init(configuration: configuration)
//        return RMRocksUseCase(repository: respository)
//    }
//    
//    func makeAvatarsUseCase() -> AvatarsUseCase {
//        let respository = RealmRepository<Avatar>.init(configuration: configuration)
//        return RMAvatarsUseCase(repository: respository)
//    }
//}
