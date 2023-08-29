//
//  MovieVO.swift
//  MovieList
//
//  Created by Ye linn htet on 8/28/23.
//

import Foundation

struct MovieVO {
    
    let id: Int?
    
    let title: String?
    
    let desc: String?
    
    let rating: Double?
    
    let duration: String?
    
    let genre: String?
    
    let releaseDate: String?
    
    let trailerLink: String?
    
    let photo: String?
    
    let isSaved: Bool?
    
    func toMovieObject() -> MovieRO {
        let object = MovieRO()
        object.id = self.id ?? 0
        object.title = self.title
        object.desc = self.desc
        object.rating = self.rating
        object.duration = self.duration
        object.genre = self.genre
        object.releaseDate = (self.releaseDate ?? "").toDate(format: .type1)
        object.genre = self.genre
        object.trailerLink = self.trailerLink
        object.photo = self.photo
        object.isSaved = self.isSaved
        return object
    }
    
}
