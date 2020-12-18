//
//  MovieDetailVO.swift
//  Movie
//
//  Created by THEIN PYAE PHYO on 2020/12/07.
//  Copyright © 2020 THEIN PYAE PHYO. All rights reserved.
//

import Foundation

struct MovieDetailVO: Codable {
    var id: Int?
    var originalTitle: String?
    var overview: String?
    var genres: [GenreVO]?
    var voteAverage: Float?
    var posterPath: String?
    var productionCompanies: [ProductionCompaniesVO]? 
    
}



//struct MovieDetailVO: Codable {
//
//    var adult: BooleanLiteralType?
//    var backdropPath: String?
//    var belongsToCollection: String?
//    var budget: Int?
//    var genres: [GenreVO]?
//    var homepage: String?
//    var id: Int?
//    var imbId: String?
//    var originalLanguage: String?
//    var originalTitle: String?
//    var overview: String?
//    var popularity: Float?
//    var posterPath: String?
//    var productionCompanies:
//       "

//adult": false,
//     "backdrop_path": "/8e2j8EeJ1z2OCmbGmMaX6xg1u2w.jpg",
//     "belongs_to_collection": null,
//     "budget": 0,
//     "genres": [
//         {
//             "id": 35,
//             "name": "Comedy"
//         }
//     ],
//     "homepage": "https://www.amazon.com/dp/B08NWNX73Q",
//     "id": 650747,
//     "imdb_id": "tt11362866",
//     "original_language": "es",
//     "original_title": "Historias lamentables",
//     "overview": "This satirical anthology tells the surreal stories of a gift for Don Horacio, a trip to the beach for Bermejo, a life-changing relationship between Tina and the young immigrant Ayoub, and a new client for a company that specializes in excuses.",
//     "popularity": 376.04,
//     "poster_path": "/sp4zXS3x4wHyL8wm8zLioiBrxuR.jpg",
//     "production_companies": [
//         {
//             "id": 16569,
//             "logo_path": null,
//             "name": "Películas Pendelton",
//             "origin_country": "ES"
//         },
//         {
//             "id": 10031,
//             "logo_path": "/cUOviFxM9l3dYuNeg89giHUaqkd.png",
//             "name": "Morena Films",
//             "origin_country": "ES"
//         },
//         {
//             "id": 981,
//             "logo_path": "/pkrdO9ykplO4Zc8edikoSX5APUN.png",
//             "name": "TVE",
//             "origin_country": "ES"
//         },
//         {
//             "id": 20580,
//             "logo_path": "/tkFE81jJIqiFYPP8Tho57MXRQEx.png",
//             "name": "Amazon Studios",
//             "origin_country": "US"
//         }
//     ],
//     "production_countries": [
//         {
//             "iso_3166_1": "ES",
//             "name": "Spain"
//         }
//     ],
//     "release_date": "2020-11-19",
//     "revenue": 0,
//     "runtime": 129,
//     "spoken_languages": [
//         {
//             "english_name": "Spanish",
//             "iso_639_1": "es",
//             "name": "Español"
//         }
//     ],
//     "status": "Released",
//     "tagline": "",
//     "title": "Historias lamentables",
//     "video": false,
//     "vote_average": 7.0,
//     "vote_count": 54
//}
