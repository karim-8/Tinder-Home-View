//
//  SuperView.swift
//  Cameloan
//
//  Created by KARIM on 10/17/19.
//  Copyright © 2019 KARIM. All rights reserved.
//

import UIKit

extension UIView {
    
    func superview<T>(of type: T.Type) -> T? {
        return superview as? T ?? superview.map { $0.superview(of: type)! }
    }
    
    func subview<T>(of type: T.Type) -> T? {
        return subviews.compactMap { $0 as? T ?? $0.subview(of: type) }.first
    }
}
