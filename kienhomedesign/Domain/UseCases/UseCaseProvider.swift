//
//  UseCaseProvider.swift
//  mvcsample
//
//  Created by dongnguyen on 18/12/2022.
//

import Foundation
public protocol UseCaseProvider {
    // Với mỗi Model được liệt kê ở Domain, chúng ta cần định nghĩa hàm tạo ra UseCase tương ứng
  
    
    func makeHomesUseCase() -> HomesUseCase
}
