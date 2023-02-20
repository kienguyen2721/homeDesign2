//
//  NetUseCaseProvider.swift
//  mvcsample
//
//  Created by dongnguyen on 18/12/2022.
//

import Foundation
final class NetUseCaseProvider: UseCaseProvider {
    
    
    
    func makeHomesUseCase() -> HomesUseCase {
        return NetHomesUseCase.init()
    }
   
   
    
    
}
