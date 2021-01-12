//
//  NowPlayingVO.swift
//  Movie
//
//  Created by THEIN PYAE PHYO on 2020/12/07.
//  Copyright © 2020 THEIN PYAE PHYO. All rights reserved.
//

import Foundation
import RealmSwift

class NowPlayingVO: Object, Codable {
    @objc dynamic var totalPages = 0
    var results = List<MovieVO>()
}

class MovieVO: Object, Codable {
    @objc dynamic var adult = false
    @objc dynamic var backdropPath: String?
    var genreIds = List<Int>()
    @objc dynamic var id = 0
    @objc dynamic var originalLanguage: String?
    @objc dynamic var originalTitle: String?
    @objc dynamic var overview: String?
    @objc dynamic var popularity: Float = 0.0
    @objc dynamic var posterPath: String?
    @objc dynamic var releaseDate: String?
    @objc dynamic var title: String?
    @objc dynamic var video = false
    @objc dynamic var voteAverage: Float = 0.0
    @objc dynamic var voteCount = 0
}

class FavouriteStateVO: Object {
    @objc dynamic var movieId: Int = 0
    @objc dynamic var state: Bool = false
}

class UpcomingVO: Object, Codable {
    @objc dynamic var totalPages = 0
    var results = List<MovieVO>()
}

    
