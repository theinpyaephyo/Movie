//
//  UserDataModel.swift
//  Movie
//
//  Created by THEIN PYAE PHYO on 2020/12/05.
//  Copyright © 2020 THEIN PYAE PHYO. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import SDWebImage

final class UserDataModel {
    
    private init() {}
    
    static let shared = UserDataModel()
    
    let decoder = JSONDecoder()
    
    var genreList: [GenreVO] = []
    
    var favouriteStateList: [Bool] = []
    
    var nowPlayingVO = NowPlayingVO()
    
    var movieDetailVO = MovieDetailVO()
    
    var productionCompany: [ProductionCompaniesVO]?
    
    
    func getMovieList(page: Int = 1,
                      success: @escaping () -> Void,
                      failure: @escaping (String) -> Void ){
        
        let parameters: [String:Any] = [
            SharedConstants.PARAM_KEY.API_KEY: SharedConstants.PARAM_VALUE.API_KEY_VALUE,
            SharedConstants.PARAM_KEY.LANGUAGE: SharedConstants.PARAM_VALUE.LANGUAGE_VALUE,
            SharedConstants.PARAM_KEY.PAGE: page
        ]
        
        NetworkClient.shared.getData(route: SharedConstants.ROUTE.GET_MOVIE_LIST, httpHeaders: [:], parameters: parameters, success: { (data) in
            
            guard let data = data as? JSON else { return }
            
            do {
                self.decoder.keyDecodingStrategy = .convertFromSnakeCase
                self.nowPlayingVO = try self.decoder.decode(NowPlayingVO.self, from: Data(data.rawData()))
                
                //favourite state list
                self.nowPlayingVO.results?.forEach { (_) in
                    self.favouriteStateList.append(false)
                }
                
                success()
            } catch let err {
                print(err)
            }
            
            
            
        }) { (err) in
            print(err)
        }
    }
    

    func getMovieDetails(movieId: Int,
                         success: @escaping () -> Void,
                         failure: @escaping (String) -> Void ) {
        
        let parameters: [String:Any] = [
            SharedConstants.PARAM_KEY.API_KEY: SharedConstants.PARAM_VALUE.API_KEY_VALUE,
            SharedConstants.PARAM_KEY.LANGUAGE: SharedConstants.PARAM_VALUE.LANGUAGE_VALUE
        ]
        
        let route = "movie/\(movieId)"
        
        NetworkClient.shared.getData(route: route, httpHeaders: [:], parameters: parameters, success: { (data) in
            
            guard let data = data as? JSON else { return }
            
            do {
                self.decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                // TODO create response object => MovieDetailsVO
//                self.nowPlayingVO = try self.decoder.decode(NowPlayingVO.self, from: Data(data.rawData()))
                self.movieDetailVO = try self.decoder.decode(MovieDetailVO.self, from: Data(data.rawData()))
                
                success()
            } catch let err {
                print(err)
            }
        }) { (err) in
            print(err)
        }
        
    }
    
    func getGenre(success: @escaping () -> Void,
                  failure: @escaping (String) -> Void) {
        
        let parameters: [String: Any] = [
            SharedConstants.PARAM_KEY.API_KEY: SharedConstants.PARAM_VALUE.API_KEY_VALUE,
            SharedConstants.PARAM_KEY.LANGUAGE: SharedConstants.PARAM_VALUE.LANGUAGE_VALUE
        ]
                
        NetworkClient.shared.getData(route: SharedConstants.ROUTE.GET_GENRE_LIST, httpHeaders: [:], parameters: parameters, success: { (data) in
            
            guard let data = data as? JSON else  { return }

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                self.genreList = try decoder.decode([GenreVO].self, from: Data(data["genres"].rawData()))
                success()
            } catch let err {
                print(err.localizedDescription)
            }
            
            
        }) { (err) in
            failure(err)
        }
    }
    
}
