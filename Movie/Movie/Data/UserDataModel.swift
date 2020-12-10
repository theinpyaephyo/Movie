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
    
    func getMovieList(page: Int = 1,
                      success: @escaping ([NowPlayingVo]) -> Void,
                      failure: @escaping (String) -> Void ){
        
        let parameters: [String:Any] = ["page":page]
        
        NetworkClient.shared.getMovieList(route: "movie/now_playing?api_key=7d56df239f3717c4641ffd5917635441&language=en-US&page=1", httpHeaders: [:], parameters: parameters, success: { (data) in
            
            guard let data = data as? JSON else { return }
            
            do {
                self.decoder.keyDecodingStrategy = .convertFromSnakeCase
                let movieLists = try self.decoder.decode([NowPlayingVo].self, from: Data(data["results"].rawData()))
                success(movieLists)
            } catch let err {
                print(err)
            }
            
            
            
        }) { (err) in
            print(err)
        }
    }
    
}
