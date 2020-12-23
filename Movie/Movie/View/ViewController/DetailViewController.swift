//
//  DetailViewController.swift
//  Movie
//
//  Created by THEIN PYAE PHYO on 2020/12/14.
//  Copyright © 2020 THEIN PYAE PHYO. All rights reserved.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    static let identifier = "DetailViewController"

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var btnBack: UIView!
    @IBOutlet weak var outerviewVoteAverage: UIView!
    @IBOutlet weak var innerviewVoteAverage: UIView!
    @IBOutlet weak var lblVoteAverage: UILabel!
    @IBOutlet weak var btnFavourite: UIView!
    @IBOutlet weak var imgFavourite: UIImageView!
    //Stack View
    @IBOutlet weak var svUpperLayer: UIView!
    @IBOutlet weak var svBelowLayer: UIView!
    @IBOutlet weak var viewGenre4: UIView!
    @IBOutlet weak var viewGenre5: UIView!
    @IBOutlet weak var viewGenre1: UIView!
    @IBOutlet weak var viewGenre2: UIView!
    @IBOutlet weak var viewGenre3: UIView!
    @IBOutlet weak var lblGenre1: UILabel!
    @IBOutlet weak var lblGenre2: UILabel!
    @IBOutlet weak var lblGenre3: UILabel!
    @IBOutlet weak var lblGenre4: UILabel!
    @IBOutlet weak var lblGenre5: UILabel!
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var lblMovieDuration: UILabel!
    @IBOutlet weak var lblOverview: UILabel!
    @IBOutlet weak var movieDetailCollectionView: UICollectionView!
    @IBOutlet weak var lblOverviewDetails: UILabel!
    
    private var movieDetailList =  MovieDetailVO()
    
    private var castList: [ProductionCompaniesVO] = []
    
    private var genreName: [String] = []
    
    private var genreCount: Int = 1
    
    private var movieDuration: Int?
    
    private var index: Int?
    
    var tableViewCellIndex: Int? {
        didSet {
            if let tableViewCellIndex = tableViewCellIndex {
                index = tableViewCellIndex
            }
        }
    }
    
    
    var movieID: Int? {
        didSet {
            if let movieID = movieID {
                
                UserDataModel.shared.getMovieDetails(movieId: movieID, success: {
                    self.movieDetailList = UserDataModel.shared.movieDetailVO
                    self.castList = UserDataModel.shared.movieDetailVO.productionCompanies ?? []
                    self.loadInitial()
                }) { (err) in
                    print(err)
                }
            }
        }
    }
    
    var favouriteState: Bool? {
        didSet {
            if let favouriteState = favouriteState {
                if favouriteState {
                    imgFavourite.tintColor = .red
                } else {
                    imgFavourite.tintColor = .systemBackground
                }
            }
            
        }
    }
    
    // change status bar text color to white
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Genre border colour
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
        
        
        //Genre corner radius
        viewGenre1.layer.cornerRadius = viewGenre1.frame.height / 8
        viewGenre2.layer.cornerRadius = viewGenre2.frame.height / 8
        viewGenre3.layer.cornerRadius = viewGenre3.frame.height / 8
        viewGenre4.layer.cornerRadius = viewGenre4.frame.height / 8
        viewGenre5.layer.cornerRadius = viewGenre5.frame.height / 8
        

        btnBack.layer.cornerRadius = btnBack.frame.width / 2
        
        btnBack.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onClick))
        btnBack.addGestureRecognizer(tapGesture)
        
        // Vote Average
        outerviewVoteAverage.layer.borderColor = UIColor.white.cgColor
        outerviewVoteAverage.layer.borderWidth = 1
        
        outerviewVoteAverage.layer.cornerRadius = outerviewVoteAverage.frame.width / 2
        innerviewVoteAverage.layer.cornerRadius = innerviewVoteAverage.frame.width / 2
        
        //Favourite
        imgFavourite.image = UIImage(systemName: "heart.fill")
        
        //Collection View
        movieDetailCollectionView.register(UINib(nibName: CastListCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CastListCollectionViewCell.identifier)
        
        movieDetailCollectionView.contentInset = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 32)
        
        movieDetailCollectionView.dataSource = self
        
        movieDetailCollectionView.delegate = self
        
        //Favourite View Button
        
        btnFavourite.isUserInteractionEnabled = true
        
        let addGesture = UITapGestureRecognizer(target: self, action: #selector(onClickFavourite))
        btnFavourite.addGestureRecognizer(addGesture)
        
    }
    
    func loadInitial() {
        
        self.lblVoteAverage.text = "\(self.movieDetailList.voteAverage ?? 0)"
        
        lblOverviewDetails.text = self.movieDetailList.overview
        
        let url = SharedConstants.posterPath + (movieDetailList.posterPath ?? "")
        self.imgProfile.sd_setImage(with: URL(string: url))
        
        //Movie Title
        lblMovieTitle.text = movieDetailList.originalTitle ?? ""
        
        //Movie Duration
        movieDuration = movieDetailList.runtime ?? 0
        let time = NSInteger(movieDuration ?? 0)
        let minutes = time %  60
        let hours = time / 60
        lblMovieDuration.text = "\(hours)" + "h " + "\(minutes)" + "mins" 

//        return NSString(format: "%0.2d:%0.2d:%0.2d.%0.3d",hours,minutes,seconds,ms)
        
        //Genre
        self.svUpperLayer.isHidden = true
        self.svBelowLayer.isHidden = true
        
        self.viewGenre1.isHidden = true
        self.viewGenre2.isHidden = true
        self.viewGenre3.isHidden = true
        self.viewGenre4.isHidden = true
        self.viewGenre5.isHidden = true
        
        self.lblGenre1.text = ""
        self.lblGenre2.text = ""
        self.lblGenre3.text = ""
        self.lblGenre4.text = ""
        self.lblGenre5.text = ""
        
        movieDetailList.genres?.forEach({ (genreID) in
            UserDataModel.shared.genreList.forEach { (genreNameId) in
                if genreID.id == genreNameId.id {
                    genreName.append(genreNameId.name ?? "")
                }
            }
        })
        genreName.forEach { (name) in
            switch genreCount {
            case 1:
                svBelowLayer.isHidden = false
                viewGenre1.isHidden = false
                lblGenre1.text = name
                genreCount+=1
                break
            case 2:
                viewGenre2.isHidden = false
                lblGenre2.text = name
                genreCount+=1
                break
            case 3:
                viewGenre3.isHidden = false
                lblGenre3.text = name
                genreCount+=1
                break
            case 4:
                svUpperLayer.isHidden = false
                viewGenre4.isHidden = false
                lblGenre4.text = name
                genreCount+=1
                break
            case 5:
                viewGenre5.isHidden = false
                lblGenre5.text = name
                
                break
            default:
                break
            }
            
        }
        genreCount = 1
        
        
        self.movieDetailCollectionView.reloadData()

    }
    
    @objc func onClick() {
        self.dismiss(animated: true, completion: nil)
        UserDataModel.shared.favouriteStateList[index ?? 0] = favouriteState ?? false
        
       
    }
    //Favourite Button Click Event
    @objc func onClickFavourite() {
        if imgFavourite.tintColor == UIColor.systemBackground {
            imgFavourite.tintColor = UIColor.red
            favouriteState = true
            
        } else {
            imgFavourite.tintColor = UIColor.systemBackground
            favouriteState = false
        }
    }
    

}

extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return castList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastListCollectionViewCell.identifier, for: indexPath) as! CastListCollectionViewCell
        cell.castList = castList[indexPath.row]
        return cell
    }
    
    
}
extension DetailViewController: UICollectionViewDelegateFlowLayout,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 175)
    }
}
