//
//  MovieVO.swift
//  MovieList
//
//  Created by Ye linn htet on 8/28/23.
//

import Foundation
import RealmSwift

class MovieRO: Object {
    @Persisted(primaryKey: true)
    var id: Int
    
    @Persisted
    var title: String?
    
    @Persisted
    var desc: String?
    
    @Persisted
    var rating: Double?
    
    @Persisted
    var duration: String?
    
    @Persisted
    var genre: String?
    
    @Persisted
    var releaseDate: Date?
    
    @Persisted
    var trailerLink: String?
    
    @Persisted
    var photo: String?
    
    @Persisted
    var isSaved: Bool?
    
    
    
}
