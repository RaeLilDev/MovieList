//
//  Realm.swift
//  MovieList
//
//  Created by Ye linn htet on 8/28/23.
//

import Foundation
import RealmSwift

class MovieRealm: NSObject {
    
    static let shared = MovieRealm()
    
    let db = try! Realm()
    
    override init() {
        
        super.init()
        
        print("Default Realm is at \(db.configuration.fileURL?.absoluteString ?? "undefined")")
    }
}
