//
//  MovieRepository.swift
//  MovieList
//
//  Created by Ye linn htet on 8/28/23.
//

import Foundation
import RealmSwift
import RxSwift
import RxRealm

protocol MovieRepository {
    func saveList(data: [MovieVO])
    
    func getList(with sortBy: String) -> Observable<[MovieRO]>
    
    func getDetail(id: Int) -> Observable<MovieRO>
    
    func update(data: MovieRO)
}

class MovieRepositoryImpl: BaseRepository, MovieRepository {
    static let shared: MovieRepository = MovieRepositoryImpl()
    
    private override init() {}
    
    func saveList(data: [MovieVO]) {
        try! realmInstance.db.write {
            realmInstance.db.add(data.map { $0.toMovieObject() }, update: .modified)
        }
        Preference.setValue(true, forKey: .isOldUser)
    }
    
    func getList(with sortBy: String) -> RxSwift.Observable<[MovieRO]> {
        let items = realmInstance.db.objects(MovieRO.self)
            .sorted(byKeyPath: sortBy, ascending: true)
        
        return Observable.array(from: items)
        
    }
    
    func getDetail(id: Int) -> RxSwift.Observable<MovieRO> {
        let items = realmInstance.db.objects(MovieRO.self)
        let movie = Array(items).first(where: { $0.id == id }) ?? MovieRO()
        return Observable.from(object: movie)
    }
    
    func update(data: MovieRO) {
        if let movie = realmInstance.db.object(ofType: MovieRO.self, forPrimaryKey: data.id) {
            try! realmInstance.db.write {
                movie.isSaved = !(movie.isSaved ?? false)
            }
        }
    }
    
    
}


