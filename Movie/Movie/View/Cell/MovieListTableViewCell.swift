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
    @IBOutlet weak var viewGenre3: UIView!
    @IBOutlet weak var viewGenre4: UIView!
    @IBOutlet weak var viewGenre5: UIView!
    @IBOutlet weak var lblGenre1: UILabel!
    @IBOutlet weak var lblGenre2: UILabel!
    @IBOutlet weak var lblGenre3: UILabel!
    @IBOutlet weak var lblGenre4: UILabel!
    @IBOutlet weak var lblGenre5: UILabel!
    
    @IBOutlet weak var btnBook: UIButton!
    @IBOutlet weak var btnFavourite: UIView!
    
    
    var baseUrl = "https://image.tmdb.org/t/p/original"
    
    var genreList: GenreVO?
    var genreName: [String] = []
    var genreCount: Int = 1
    
    var movieList: NowPlayingVo? {
        didSet {
            if let movieList = movieList {
                
                
                //Clear lblGenre
                
                lblGenre1.text = ""
                lblGenre2.text = ""
                lblGenre3.text = ""
                lblGenre4.text = ""
                lblGenre5.text = ""
                
                viewGenre1.isHidden = true
                viewGenre2.isHidden = true
                viewGenre3.isHidden = true
                viewGenre4.isHidden = true
                viewGenre5.isHidden = true
                
            
                lblMovieTitle.text = movieList.title ?? ""
                
                let imageURL = baseUrl + (movieList.posterPath ?? "")
                
                imgMoviePoster.sd_setImage(with: URL(string: imageURL))
                
                lblVoteAverage.text = "\(movieList.voteAverage ?? 0)"
                
                lblDuration.text = ""
                
                
                movieList.genreIds?.forEach({ (mvGenreId) in
                    MainViewController.genreList.forEach { (genreData) in
                        if mvGenreId == genreData.id {
//                            genreName.append(contentsOf: "\(genreData.name)" ?? "")
                            genreName.append(genreData.name ?? "")
                        }
                    }
                })
                
                genreName.forEach { (name) in
                 
                    switch genreCount {
                    case 1:
                        lblGenre1.text = name
                        viewGenre1.isHidden = false
                        genreCount+=1
                        break
                    case 2:
                        lblGenre2.text = name
                        viewGenre2.isHidden = false
                        genreCount+=1
                    break
                    case 3:
                        lblGenre3.text = name
                        viewGenre3.isHidden = false
                        genreCount+=1
                        break
                    case 4:
                        lblGenre4.text = name
                        viewGenre4.isHidden = false
                        genreCount+=1
                        break
                    case 5:
                        lblGenre5.text = name
                        viewGenre5.isHidden = false
                        break
                        
                    default:
                        break
                    }
                }
                genreCount = 1
                genreName = []
                
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
        
        viewGenre3.layer.borderColor = UIColor.white.cgColor
        viewGenre3.layer.borderWidth = 1
        
        viewGenre4.layer.borderColor = UIColor.white.cgColor
        viewGenre4.layer.borderWidth = 1
        
        viewGenre5.layer.borderColor = UIColor.white.cgColor
        viewGenre5.layer.borderWidth = 1
        
        
        //Genre View Corner Radius
        viewGenre1.layer.cornerRadius = viewGenre1.frame.height / 8
        viewGenre2.layer.cornerRadius = viewGenre2.frame.height / 8
        viewGenre3.layer.cornerRadius = viewGenre3.frame.height / 8
        viewGenre4.layer.cornerRadius = viewGenre4.frame.height / 8
        viewGenre5.layer.cornerRadius = viewGenre5.frame.height / 8
        
        //Button Corner Radius
        btnBook.layer.cornerRadius = btnBook.frame.height / 8
        
        //Button Favourite
        btnFavourite.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onClick))
        btnFavourite.addGestureRecognizer(tapGesture)
        
        self.selectionStyle = .none
        
        
    }
    
    @objc func onClick() {
        if ivFavourite.tintColor == .none {
            ivFavourite.tintColor = .red
        } else {
            ivFavourite.tintColor = .systemba
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
 
}
