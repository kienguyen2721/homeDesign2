//
//  BaseView.swift
//  mvcsample
//
//  Created by Nguyen Dinh Dong on 25/11/2022.
//

import Foundation
import UIKit

class BaseView: UIView {
    
    // MARK: Properties
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    // MARK: Common init
    
    /// Hàm khởi tạo view chung, mọi view trong dự án phải được kết thừa từ BaseView
    /// from the given components.
    ///
    func commonInit() {
        fromNib()
    }
    
    deinit {
        print("Deinit: " + String(describing: type(of: self)))
    }
}
