////
////  RMAvatarsUseCase.swift
////  mvcsample
////
////  Created by dongnguyen on 20/12/2022.
////
//
//import Foundation
//final class RMAvatarsUseCase<RealmRepository>: AvatarsUseCase where RealmRepository: AbstractRepository, RealmRepository.T == Avatar {
//    let repository: RealmRepository
//    
//    init(repository: RealmRepository) {
//        self.repository = repository
//    }
//    
//    func getAll(complete: @escaping ([Avatar]) -> Void) {
//        complete(repository.queryAll())
//    }
//    
//    func save(avatar: Avatar) {
//        repository.save(entity: avatar)
//    }
//    
//    func delete(avatar: Avatar) {
//        repository.delete(entity: avatar)
//    }
//    
//    func findAvatar(with id: String, complete: @escaping (Avatar?) -> Void) {
//        let predicate = NSPredicate(format: "uid == %@", id)
//        complete(repository.query(with: predicate).first)
//    }
//    
//  
//}
