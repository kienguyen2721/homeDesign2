//
//  RealmRepresentable.swift
//  mvcsample
//
//  Created by dongnguyen on 18/12/2022.
//

import Foundation
protocol RealmRepresentable {
    associatedtype RealmType: DomainConvertibleType
    var uid: String { get }
    func asRealm() -> RealmType
}
