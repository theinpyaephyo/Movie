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
        
    }
    
    func loadInitial() {
        
        self.lblVoteAverage.text = "\(self.movieDetailList.voteAverage ?? 0)"
        
        lblOverviewDetails.text = self.movieDetailList.overview
        
        let url = SharedConstants.posterPath + (movieDetailList.posterPath ?? "")
        self.imgProfile.sd_setImage(with: URL(string: url))
        
        self.movieDetailCollectionView.reloadData()

    }
    
    @objc func onClick() {
        self.dismiss(animated: true, completion: nil)
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
