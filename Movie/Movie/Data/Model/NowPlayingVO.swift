//
//  NowPlayingVO.swift
//  Movie
//
//  Created by THEIN PYAE PHYO on 2020/12/07.
//  Copyright © 2020 THEIN PYAE PHYO. All rights reserved.
//

import Foundation

struct NowPlayingVo: Codable {
    
    var adult: BooleanLiteralType?
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
    var video: BooleanLiteralType?
    var voteAverage: Float?
    var voteCount: Int?
    
//    "results": [
//    {
//        "adult": false,
//        "backdrop_path": "/jeAQdDX9nguP6YOX6QSWKDPkbBo.jpg",
//        "genre_ids": [
//            28,
//            14,
//            878
//        ],
//        "id": 590706,
//        "original_language": "en",
//        "original_title": "Jiu Jitsu",
//        "overview": "Every six years, an ancient order of jiu-jitsu fighters joins forces to battle a vicious race of alien invaders. But when a celebrated war hero goes down in defeat, the fate of the planet and mankind hangs in the balance.",
//        "popularity": 2267.77,
//        "poster_path": "/eLT8Cu357VOwBVTitkmlDEg32Fs.jpg",
//        "release_date": "2020-11-20",
//        "title": "Jiu Jitsu",
//        "video": false,
//        "vote_average": 5.7,
//        "vote_count": 119
//    },
}
