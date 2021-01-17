//
//  RealmHelper.swift
//  Movie
//
//  Created by Ye Ko on 10/01/2021.
//  Copyright © 2021 THEIN PYAE PHYO. All rights reserved.
//

import Foundation
import RealmSwift

class RealmHelper {
    
    private init() {}
    
    static let shared = RealmHelper()
    
    let realm = try! Realm(configuration: Realm.Configuration(schemaVersion: 4))
    
    func deleteMovies() {
        let movies = realm.objects(MovieVO.self)
        try! realm.write {
            realm.delete(movies)
        }
    }
    
    // MARK: - NowPlayingVO
    
    // create
    func insertNowPlayingMovie(nowPlaying: NowPlayingVO) {
        if let nowPlayingVOs = realm.objects(NowPlayingVO.self).first {
            try! realm.write {
                nowPlayingVOs.results.append(objectsIn: nowPlaying.results)
            }
            print(nowPlayingVOs.results.count)
        } else {
            try! realm.write {
                realm.add(nowPlaying)
            }
        }
    }
    
    // read all
    func retrieveNowPlayingMovie() -> Results<NowPlayingVO> {
        return realm.objects(NowPlayingVO.self)
    }
    
    // delete
    func deleteNowPlayingMovie() {
        let nowPlayingVOs = realm.objects(NowPlayingVO.self)
        try! realm.write {
            realm.delete(nowPlayingVOs)
        }
    }
    
    //MARK: - FavouriteStateVO
    
    // create
    func insertFavouriteState(favouriteState: FavouriteStateVO) {
        try! realm.write {
            realm.add(favouriteState)
        }
    }
    
    // read
    func retrieveFavouriteState(movieId: Int) -> FavouriteStateVO? {
        return realm.objects(FavouriteStateVO.self).filter("movieId == %@", movieId).first
    }
    
    // read all
    func retrieveFavouriteState() -> Results<FavouriteStateVO> {
        return realm.objects(FavouriteStateVO.self)
    }

    // update
    func updateFavouriteStae(movieId: Int, favouriteState: Bool) {
        guard let favouriteVO = realm.objects(FavouriteStateVO.self).filter("movieId == %@", movieId).first else { return }
        try! realm.write {
            favouriteVO.state = favouriteState
        }
    }
    
    // delete
    func deleteFavouriteState() {
        let favouriteStates = realm.objects(FavouriteStateVO.self)
        try! realm.write {
            realm.delete(favouriteStates)
        }
    }
    
    //MARK: - UpcomingMovieVO
    
    // create
    func insertUpcomingMovie(upcoming: UpcomingVO) {
        if let upcomingVOs = realm.objects(UpcomingVO.self).first {
            try! realm.write {
                upcomingVOs.results = upcoming.results
            }
        } else {
            try! realm.write {
                realm.add(upcoming)
            }
        }
    }
    
    // read all
    func retrieveUpcomingMovie() -> Results<UpcomingVO> {
        return realm.objects(UpcomingVO.self)
    }
    
    //MARK: - Genre
    
    // create genre
    func insertGenre(genre: GenreVO) {
        try! realm.write {
            realm.add(genre)
        }
    }

    // read genre all
    func retrieveGenre() -> Results<GenreVO> {
        return realm.objects(GenreVO.self)
    }
    
    // delete
    func deleteGenre() {
        let genres = realm.objects(GenreVO.self)
        try! realm.write {
            realm.delete(genres)
        }
    }
}

