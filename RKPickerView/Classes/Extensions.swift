//
//  Extensions.swift
//  RKPickerView
//
//  Created by Rayehe on 7/1/1397 AP.
//  Copyright © 1397 Rayehe. All rights reserved.
//

import Foundation
import UIKit

protocol Reusable : class {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String { return String(describing: self) }
}

//MARK: -
extension UITableView {
    
    func registerReusableCell<T: UITableViewCell>(_: T.Type) where T: Reusable {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T where T: Reusable {
        
        return dequeueReusableCell(withIdentifier: T.reuseIdentifier) as! T
    }
    
    func dequeueReusableCell<T: UITableViewCell>() -> T where T: Reusable {
        return dequeueReusableCell(withIdentifier: T.reuseIdentifier) as! T
    }
}
