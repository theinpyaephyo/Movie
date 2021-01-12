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
        
    var upComingFavouriteStateList: [Bool] = []
        
    var upComingVO = UpcomingVO()
    
    var movieDetailVO = MovieDetailVO()
        
    func getNowPlayingMovieList(page: Int = 1,
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
                let nowPlayingVO = try self.decoder.decode(NowPlayingVO.self, from: Data(data.rawData()))
                                
                RealmHelper.shared.insertNowPlayingMovie(nowPlaying: nowPlayingVO)
                if RealmHelper.shared.retrieveFavouriteState().count != RealmHelper.shared.retrieveNowPlayingMovie().first?.results.count {
                    nowPlayingVO.results.forEach { (movieVO) in
                        let favouriteStateVO = FavouriteStateVO()
                        favouriteStateVO.movieId = movieVO.id
                        favouriteStateVO.state = false
                        RealmHelper.shared.insertFavouriteState(favouriteState: favouriteStateVO)
                    }
                }
                success()
                
            } catch let err {
                print(err)
            }
            
        }) { (err) in
            print(err)
        }
    }
    
    func getUpcomingMovieList(page: Int = 1,
                      success: @escaping () -> Void,
                      failure: @escaping (String) -> Void ){
        
        let parameters: [String:Any] = [
            SharedConstants.PARAM_KEY.API_KEY: SharedConstants.PARAM_VALUE.API_KEY_VALUE,
            SharedConstants.PARAM_KEY.LANGUAGE: SharedConstants.PARAM_VALUE.LANGUAGE_VALUE,
            SharedConstants.PARAM_KEY.PAGE: page
        ]
        
        NetworkClient.shared.getData(route: SharedConstants.ROUTE.GET_UPCOMING_LIST, httpHeaders: [:], parameters: parameters, success: { (data) in
            
            guard let data = data as? JSON else { return }
            
            do {
                self.decoder.keyDecodingStrategy = .convertFromSnakeCase
                self.upComingVO = try self.decoder.decode(UpcomingVO.self, from: Data(data.rawData()))
                
                //favourite state list
                self.upComingVO.results.forEach { (_) in
                    self.upComingFavouriteStateList.append(false)
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
    
    func getGenre(failure: @escaping (String) -> Void) {
        
        let parameters: [String: Any] = [
            SharedConstants.PARAM_KEY.API_KEY: SharedConstants.PARAM_VALUE.API_KEY_VALUE,
            SharedConstants.PARAM_KEY.LANGUAGE: SharedConstants.PARAM_VALUE.LANGUAGE_VALUE
        ]
                
        NetworkClient.shared.getData(route: SharedConstants.ROUTE.GET_GENRE_LIST, httpHeaders: [:], parameters: parameters, success: { (data) in
            
            guard let data = data as? JSON else  { return }

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let genreList = try decoder.decode([GenreVO].self, from: Data(data["genres"].rawData()))
                
                RealmHelper.shared.deleteGenre()
                genreList.forEach { (genreVO) in
                    RealmHelper.shared.insertGenre(genre: genreVO)
                }
                
            } catch let err {
                print(err.localizedDescription)
            }
            
            
        }) { (err) in
            failure(err)
        }
    }
    
}
