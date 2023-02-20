//
//  RMRocksUseCase.swift
//  mvcsample
//
//  Created by dongnguyen on 19/12/2022.
//
//
//import Foundation
//import Realm
//import RealmSwift
//
//final class RMRocksUseCase<RealmRepository>: RocksUseCase where RealmRepository: AbstractRepository, RealmRepository.T == Rock {
//    func getAll(complete: @escaping ([Rock]) -> Void) {
//        complete(repository.queryAll())
//    }
//    
//    func save(rock: Rock) {
//        repository.save(entity: rock)
//    }
//    
//    func delete(rock: Rock) {
//        repository.delete(entity: rock)
//    }
//    
//    func findRock(with id: String, complete: @escaping (Rock?) -> Void) {
//        
//    }
//    
//    
//    
//    let repository: RealmRepository
//    
//    init(repository: RealmRepository) {
//        self.repository = repository
//    }
//    
////    func getAll(complete: @escaping ([Todo]) -> Void) {
////        complete(repository.queryAll())
////    }
////
////    func save(todo: Todo) {
////        repository.save(entity: todo)
////    }
////
////    func delete(todo: Todo) {
////        // Code
////    }
////
////    func findTodo(with id: String, complete: @escaping (Todo?) -> Void) {
////        let predicate = NSPredicate(format: "uid == %@", id)
////        complete(repository.query(with: predicate).first)
////    }
//}
