//
//  DomainConvertibleType.swift
//  mvcsample
//
//  Created by dongnguyen on 18/12/2022.
//

import Foundation
protocol DomainConvertibleType {
    associatedtype DomainType
    func asDomain() -> DomainType
}
