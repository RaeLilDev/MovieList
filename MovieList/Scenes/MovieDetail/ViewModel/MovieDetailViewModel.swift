//
//  MovieDetailViewModel.swift
//  MovieList
//
//  Created by Ye linn htet on 8/28/23.
//

import Foundation
import RxSwift
import RxCocoa

class MovieDetailViewModel {
    
    private let disposeBag = DisposeBag()
    private var movieModel: MovieModel!
    private var movieId: Int!
    
    var movieObservable = BehaviorRelay<MovieRO?>(value: nil)
    
    init(movieModel: MovieModel, movieId: Int) {
        self.movieModel = movieModel
        self.movieId = movieId
    }
    
    func fetchMovieDetail() {
        movieModel.getMovieDetail(with: movieId).subscribe(onNext: {[weak self] data in
            guard let self = self else { return }
            self.movieObservable.accept(data)
        }).disposed(by: disposeBag)
    }
    
    func manageWatchList() {
        let movie = movieObservable.value ?? MovieRO()
        movieModel.updateWatchList(with: movie)
    }
    
    func getTrailerLink() -> String {
        movieObservable.value?.trailerLink ?? ""
    }
    
}
