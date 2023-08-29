//
//  UITableView++.swift
//  MovieList
//
//  Created by Ye linn htet on 8/28/23.
//

import UIKit

extension UITableView {
    
    func registerCell<T: UITableViewCell>(from type: T.Type) {
        let nib = UINib(nibName: String(describing: T.self), bundle: nil)
        register(nib, forCellReuseIdentifier: String(describing: T.self))
    }
    
    func getCell<T: UITableViewCell>(from type: T.Type, at indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as! T
    }

}
