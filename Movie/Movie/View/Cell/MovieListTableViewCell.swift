//
//  MovieListTableViewCell.swift
//  Movie
//
//  Created by THEIN PYAE PHYO on 2020/12/05.
//  Copyright © 2020 THEIN PYAE PHYO. All rights reserved.
//

import UIKit
import SDWebImage

class MovieListTableViewCell: UITableViewCell {
    
    static let identifier = "MovieListTableViewCell"

    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var imgMoviePoster: UIImageView!
    @IBOutlet weak var lblVoteAverage: UILabel!
    @IBOutlet weak var ivFavourite: UIImageView!
    @IBOutlet weak var lblDuration: UILabel!
    
    var baseUrl = "http://image.tmdb.org/t/p/w185"
    
    var movieList: NowPlayingVo? {
        didSet {
            if let movieList = movieList {
                
                lblMovieTitle.text = movieList.title ?? ""
                
                let imageURL = baseUrl + (movieList.posterPath ?? "")
                
                imgMoviePoster.sd_setImage(with: URL(string: imageURL))
                
                lblVoteAverage.text = "\(movieList.voteAverage ?? 0)"
                
                lblDuration.text = ""

            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        ivFavourite.image = UIImage(systemName: "heart.fill")
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}
