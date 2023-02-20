////
////  RMTodoUseCases.swift
////  mvcsample
////
////  Created by dongnguyen on 18/12/2022.
////
//
//import Foundation
//import Realm
//import RealmSwift
//
//final class RMTodoUseCase<RealmRepository>: TodosUseCase where RealmRepository: AbstractRepository, RealmRepository.T == Todo {
//    let repository: RealmRepository
//    
//    init(repository: RealmRepository) {
//        self.repository = repository
//    }
//    
//    func getAll(complete: @escaping ([Todo]) -> Void) {
//        complete(repository.queryAll())
//    }
//    
//    func save(todo: Todo) {
//        repository.save(entity: todo)
//    }
//    
//    func delete(todo: Todo) {
//        // Code
//        repository.delete(entity: todo)
//    }
//    
//    func findTodo(with id: String, complete: @escaping (Todo?) -> Void) {
//        let predicate = NSPredicate(format: "uid == %@", id)
//        complete(repository.query(with: predicate).first)
//    }
//    
//    func update(todo: Todo) {
//        repository.update(entity: todo)
//    }
//}
