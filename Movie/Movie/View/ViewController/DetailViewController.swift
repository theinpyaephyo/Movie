//
//  DetailViewController.swift
//  Movie
//
//  Created by THEIN PYAE PHYO on 2020/12/14.
//  Copyright © 2020 THEIN PYAE PHYO. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    static let identifier = "DetailViewController"

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
        
        
        
       
    }
    
    @objc func onClick() {
        self.dismiss(animated: true, completion: nil)
    }
    

}
