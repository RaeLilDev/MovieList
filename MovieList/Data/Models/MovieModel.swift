//
//  MovieModel.swift
//  MovieList
//
//  Created by Ye linn htet on 8/28/23.
//

import Foundation
import RxSwift


protocol MovieModel {
    
    func saveMovieList(with data: [MovieVO])
    
    func getMovieList(with key: String) -> Observable<[MovieRO]>
    
    func getMovieDetail(with id: Int) -> Observable<MovieRO>
    
    func updateWatchList(with data: MovieRO)
}

class MovieModelImpl: MovieModel{
    private let movieRepository = MovieRepositoryImpl.shared
    
    static let shared = MovieModelImpl()
    
    private init() {}
    
    func saveMovieList(with data: [MovieVO]) {
        movieRepository.saveList(data: data)
    }
    
    func getMovieList(with key: String) -> Observable<[MovieRO]> {
        movieRepository.getList(with: key)
    }
    
    func getMovieDetail(with id: Int) -> Observable<MovieRO> {
        movieRepository.getDetail(id: id)
    }
    
    func updateWatchList(with data: MovieRO) {
        movieRepository.update(data: data)
    }
}
