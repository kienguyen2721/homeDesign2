////
////  RMTodo.swift
////  mvcsample
////
////  Created by dongnguyen on 18/12/2022.
////
//
//import Foundation
//import RealmSwift
//import Realm
//
///*
//  Dành cho việc lưu trữ trong realm
//  Bước 1: Vào Domain/Entries -> Tạo 1 Entry. Ví dụ: Rock
//  Bước 2: Vào Domain/UseCases -> Tạo 1 UseCase tương ứng. Ví dụ RocksUseCase.
//  - Hint: Đặt câu hỏi user có thể làm gì với Model Rock này? Thông thường là CRUD
//  Bước 2.1: Vào Domain/UseCase/UseCaseProvider -> Viết 1 function để tạo ra UseCase tương ứng
//  Bước 2: Vào RealmPlatform/Entities -> Tạo 1 Entity: Ví dụ RMRock
//  Bước 3 Vào RealmPlatform/UseCases -> Tạo useCase tương ứng.
//  - Hint: Xem ví dụ với TodosUseCase
//  Bước 4: Vào RealmPlatform/RMUseCaseProvider -> viết hàm CỤ THỂ HOÁ việc tạo ra useCase
// **/
//
//// Source: https://www.mongodb.com/docs/realm/sdk/swift/model-data/define-model/object-models/
////class RMTodo: Object {
////    @Persisted(primaryKey: true) var uid: String = UUID().uuidString
////    @Persisted var name = ""
////    @Persisted var desc = ""
////    @Persisted var createAt: Date = Date()
////    // Required enum property
////    @Persisted var comment: String = ""
////    @Persisted var status:TaskStatusEnum?
////}
//
//enum TaskStatusEnum: String, PersistableEnum {
//    case notStarted
//    case inProgress
//    case complete
//}
//
////extension RMTodo: DomainConvertibleType {
////    func asDomain() -> Todo {
////        let todo = Todo()
////        todo.uid = uid
////        todo.name = name
////        todo.createAt = createAt
////        todo.status = status
////        todo.comment = comment
////        return todo
////    }
////}
//
//extension Todo: RealmRepresentable {
//    func asRealm() -> RMTodo {
//        let todo = RMTodo()
//        todo.uid = uid
//        todo.name = name
//        todo.createAt = createAt
//        todo.status = status
//        todo.comment = comment
//        return todo
//    }
//}
