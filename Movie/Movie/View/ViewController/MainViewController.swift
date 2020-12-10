//
//  MainViewController.swift
//  Movie
//
//  Created by THEIN PYAE PHYO on 2020/12/03.
//  Copyright © 2020 THEIN PYAE PHYO. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    static let identifier = "MainViewController"
    
    var count: Int = 5
    
    var movieList: [NowPlayingVo] = []
    
    var page = 1

    @IBOutlet weak var movieListTableView: UITableView!
    @IBOutlet weak var scMovieTab: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let selected = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let normal = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        scMovieTab.setTitleTextAttributes(normal, for: .normal)
        scMovieTab.setTitleTextAttributes(selected, for: .selected)
        
        movieListTableView.register(UINib(nibName: MovieListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: MovieListTableViewCell.identifier)
        
        movieListTableView.dataSource = self
        
        
        loadInitialData()
       
    }
    
    func loadInitialData() {
        UserDataModel.shared.getMovieList(success: { (movieLists) in
            self.movieList = movieLists
            self.movieListTableView.reloadData()
        }) { (err) in
            print(err)
        }
    }

   

}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.identifier, for: indexPath) as! MovieListTableViewCell
        cell.movieList = movieList[indexPath.row]
        return cell
    }
    
    
}
