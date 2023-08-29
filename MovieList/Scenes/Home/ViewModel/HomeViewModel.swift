//
//  HomeViewModel.swift
//  MovieList
//
//  Created by Ye linn htet on 8/28/23.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel {
    
    private var movieModel: MovieModel
    private let disposeBag = DisposeBag()
    
    var movieListObservable = BehaviorRelay<[MovieRO]>(value: [])
    
    init(movieModel: MovieModel) {
        self.movieModel = movieModel
    }
    
    func saveMovieList() {
        if isNewUser() {
            movieModel.saveMovieList(with: movieList)
        }
    }
    
    func fetchMovieList(by key: String) {
        movieModel.getMovieList(with: key).subscribe(onNext: {[weak self] data in
            guard let self = self else { return }
            self.movieListObservable.accept(data)
        }).disposed(by: disposeBag)
    }
    
    func isNewUser() -> Bool {
        !Preference.getBool(forKey: .isOldUser)
    }
    
    func getMovieCount() -> Int {
        return movieListObservable.value.count
    }
    
    func getMovie(by index: Int) -> MovieRO {
        return movieListObservable.value[index]
    }
    
}
