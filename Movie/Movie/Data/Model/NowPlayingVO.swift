//
//  NowPlayingVO.swift
//  Movie
//
//  Created by THEIN PYAE PHYO on 2020/12/07.
//  Copyright © 2020 THEIN PYAE PHYO. All rights reserved.
//

import Foundation

struct NowPlayingVO: Codable {
    var totalPages: Int?
    var results: [MovieVO]?
}

struct MovieVO: Codable {
    var adult: Bool?
    var backdropPath: String?
    var genreIds: [Int]?
    var id: Int?
    var originalLanguage: String?
    var originalTitle: String?
    var overview: String?
    var popularity: Float?
    var posterPath: String?
    var releaseDate: String?
    var title: String?
    var video: Bool?
    var voteAverage: Float?
    var voteCount: Int?
}
    
