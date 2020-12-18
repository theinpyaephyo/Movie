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
        
    private var movieList: [MovieVO] = []
    
    let activityIndicator = UIActivityIndicatorView()
    
    private var page = 1

    @IBOutlet weak var movieListTableView: UITableView!
    @IBOutlet weak var scMovieTab: UISegmentedControl!
    @IBOutlet weak var imgProfile: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let selected = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let normal = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        scMovieTab.setTitleTextAttributes(normal, for: .normal)
        scMovieTab.setTitleTextAttributes(selected, for: .selected)
        
        movieListTableView.register(UINib(nibName: MovieListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: MovieListTableViewCell.identifier)
        
        movieListTableView.dataSource = self
        
        movieListTableView.delegate = self
        
        movieListTableView.separatorStyle = .none
        
       
        

        
        imgProfile.layer.cornerRadius = imgProfile.frame.width / 2
        
        loadInitialData()
       
    }
    
    private func loadInitialData() {
        
        UserDataModel.shared.getMovieList(success: {
            
            UserDataModel.shared.getGenre(success: {
                self.movieList = UserDataModel.shared.nowPlayingVO.results ?? []
                self.movieListTableView.reloadData()
            }) { (err) in
                print(err)
            }
            
        }) { (err) in
            print(err)
        }
    }
    
    private func loadMoreData(page: Int) {
        showTableViewBottomIndicator(tableView: movieListTableView)
        UserDataModel.shared.getMovieList(page: page, success: {
            self.hideTableViewBottomIndicator(tableView: self.movieListTableView)
            
            self.movieList.append(contentsOf: UserDataModel.shared.nowPlayingVO.results ?? [])
            self.movieListTableView.reloadData()
        }) { (err) in
            self.hideTableViewBottomIndicator(tableView: self.movieListTableView)
            print(err)
        }

    }
    
    private func showTableViewBottomIndicator(tableView: UITableView) {
        activityIndicator.startAnimating()
        activityIndicator.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 44)
        tableView.tableFooterView = activityIndicator
    }

    private func hideTableViewBottomIndicator(tableView: UITableView) {
        activityIndicator.stopAnimating()
        tableView.tableFooterView = UIView()
    }
    
}


extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.identifier, for: indexPath) as! MovieListTableViewCell
        cell.movie = movieList[indexPath.row]
        cell.delegate = self
        cell.favouriteState = UserDataModel.shared.favouriteStateList[indexPath.row]
        cell.index = indexPath.row
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: DetailViewController.identifier) as DetailViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        vc.movieID = movieList[indexPath.row].id
        vc.favouriteState = UserDataModel.shared.favouriteStateList[indexPath.row]
    }
        
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        // check tableview reachs end method
        if movieListTableView.contentOffset.y >= (movieListTableView.contentSize.height - movieListTableView.frame.size.height) {
            if page <= (UserDataModel.shared.nowPlayingVO.totalPages ?? 0) {
                page += 1
                loadMoreData(page: page)
            }
        }
    }
    
}

extension MainViewController: MovieListItemDelegate {
    func onTapFavourite(index: Int, state: Bool) {
        UserDataModel.shared.favouriteStateList[index] = state
        movieListTableView.reloadData()
    }
}



