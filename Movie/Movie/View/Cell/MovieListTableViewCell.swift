//
//  MovieListTableViewCell.swift
//  Movie
//
//  Created by THEIN PYAE PHYO on 2020/12/05.
//  Copyright © 2020 THEIN PYAE PHYO. All rights reserved.
//

import UIKit
import SDWebImage
import QuartzCore

class MovieListTableViewCell: UITableViewCell {
    
    static let identifier = "MovieListTableViewCell"

    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var imgMoviePoster: UIImageView!
    @IBOutlet weak var lblVoteAverage: UILabel!
    @IBOutlet weak var ivFavourite: UIImageView!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var innerViewVoteAverage: UIView!
    @IBOutlet weak var outerViewVoteAverage: UIView!
    @IBOutlet weak var viewGenre1: UIView!
    @IBOutlet weak var viewGenre2: UIView!
    @IBOutlet weak var btnBook: UIButton!
    
    
    var baseUrl = "https://image.tmdb.org/t/p/original"
    
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
        imgMoviePoster.layer.cornerRadius = 30
        
        outerViewVoteAverage.layer.cornerRadius = outerViewVoteAverage.frame.width / 2
        innerViewVoteAverage.layer.cornerRadius = innerViewVoteAverage.frame.width / 2
        
        //OuterView Border Colour Change
        outerViewVoteAverage.layer.borderColor = UIColor.white.cgColor
        outerViewVoteAverage.layer.borderWidth = 1
        
        //Genre View Border Colour Change
        viewGenre1.layer.borderColor = UIColor.white.cgColor
        viewGenre1.layer.borderWidth = 1
        
        viewGenre2.layer.borderColor = UIColor.white.cgColor
        viewGenre2.layer.borderWidth = 1
        
        //Genre View Corner Radius
        viewGenre1.layer.cornerRadius = viewGenre1.frame.height / 8
        viewGenre2.layer.cornerRadius = viewGenre2.frame.height / 8
        
        //Button Corner Radius
        btnBook.layer.cornerRadius = btnBook.frame.height / 8
        
        
        
        self.selectionStyle = .none
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}
