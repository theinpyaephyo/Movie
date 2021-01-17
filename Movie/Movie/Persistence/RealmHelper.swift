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
    
    let realm = try! Realm(configuration: Realm.Configuration(schemaVersion: 1))
    
    
//    CRUD
    //create -> insert/ add
    //1. object ->
    //2. add
    //read -> retrieve
    //1. single (id) / all => Type
    //
    //update -> favourite state
    //delete ->
    
    
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
    func insertFavouriteState(favouriteState: NowPlayingFavouriteStateVO) {
        try! realm.write {
            realm.add(favouriteState)
        }
    }
    
    // read
    func retrieveFavouriteState(movieId: Int) -> NowPlayingFavouriteStateVO? {
        return realm.objects(NowPlayingFavouriteStateVO.self).filter("movieId == %@", movieId).first
    }
    
    // read all
    func retrieveFavouriteState() -> Results<NowPlayingFavouriteStateVO> {
        return realm.objects(NowPlayingFavouriteStateVO.self)
    }

    // update
    func updateFavouriteStae(movieId: Int, favouriteState: Bool) {
        guard let favouriteVO = realm.objects(NowPlayingFavouriteStateVO.self).filter("movieId == %@", movieId).first else { return }
        try! realm.write {
            favouriteVO.state = favouriteState
        }
    }
    
    // delete
    func deleteFavouriteState() {
        let favouriteStates = realm.objects(NowPlayingFavouriteStateVO.self)
        try! realm.write {
            realm.delete(favouriteStates)
        }
    }
    
    //MARK: - UpcomingMovieVO
    
    // TODO
    
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

