//
//  MainViewController.swift
//  Movie
//
//  Created by THEIN PYAE PHYO on 2020/12/03.
//  Copyright © 2020 THEIN PYAE PHYO. All rights reserved.
//

// Persistence -> App with local database
//1. UserDeafults => value/ key
//2. Property List => value/ key
//3. Core Data => Database Level
//4. Realm => Third party Database Level
//5. SQLite => Light weight database


import UIKit
import RealmSwift

class MainViewController: UIViewController {
    
    static let identifier = "MainViewController"
    
    private var nowPlayingMovieList = List<MovieVO>()
    
    //upcoming
    private var upcomingMovieList = List<MovieVO>()
    
    let activityIndicator = UIActivityIndicatorView()
    
    private var page = 1
    //upcoming
    private var upcomingPage = 1
    
    private var selectedTab = 0
    
    var list: [MovieVO] = []
    
    @IBOutlet weak var movieListTableView: UITableView!
    @IBOutlet weak var scMovieTab: UISegmentedControl!
    @IBOutlet weak var imgProfile: UIImageView!
    
    @IBAction func scMovieTab(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            loadInitialData()
            selectedTab = 0
            // store persistence layer
            UserDefaults.standard.set(0, forKey: "SC_Seletect_Tab")
        } else {
            loadUpcomingMovieData()
            selectedTab = 1
            // store persistence layer
            UserDefaults.standard.set(1, forKey: "SC_Seletect_Tab")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        let selectedIndex = UserDefaults.standard.integer(forKey: "SC_Seletect_Tab")
        scMovieTab.selectedSegmentIndex = selectedIndex
        
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
        
        loadGenre()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.movieListTableView.reloadData()
    }
    
    private func loadGenre() {
        UserDataModel.shared.getGenre { (err) in
            print(err)
        }
    }
    
    private func loadInitialData() {
        
        if let nowPlayingVO = RealmHelper.shared.realm.objects(NowPlayingVO.self).first {
        
            page = UserDefaults.standard.integer(forKey: SharedConstants.KEY_NOW_PLAYING_PAGE)

            nowPlayingVO.results.forEach({ (movieVO) in
                self.nowPlayingMovieList.append(movieVO)
            })
            
            self.movieListTableView.reloadData()
            
        } else {
            
            UserDataModel.shared.getNowPlayingMovieList(success: {
                
                let nowPlayingVO = RealmHelper.shared.retrieveNowPlayingMovie().first
                nowPlayingVO?.results.forEach({ (movieVO) in
                    self.nowPlayingMovieList.append(movieVO)
                })
            
                print("Realm is located at:", RealmHelper.shared.realm.configuration.fileURL!)
                
                self.movieListTableView.reloadData()
                
            }) { (err) in
                print(err)
            }
            
        }
        
    }
    
    private func loadUpcomingMovieData() {
        
        // TODO
        UserDataModel.shared.getUpcomingMovieList(success: {
            // TODO
            self.upcomingMovieList = UserDataModel.shared.upComingVO.results
            self.movieListTableView.reloadData()
            
        }) { (err) in
            print(err)
        }
    }
    
    private func loadMoreData(page: Int) {
        
        showTableViewBottomIndicator(tableView: movieListTableView)
        UserDataModel.shared.getNowPlayingMovieList(page: page, success: {
        
            UserDefaults.standard.set(page, forKey: SharedConstants.KEY_NOW_PLAYING_PAGE)
            
            self.hideTableViewBottomIndicator(tableView: self.movieListTableView)
            
            let nowPlayingVO = RealmHelper.shared.retrieveNowPlayingMovie().first
            self.nowPlayingMovieList.removeAll()
            nowPlayingVO?.results.forEach({ (movieVO) in
                self.nowPlayingMovieList.append(movieVO)
            })
            self.movieListTableView.reloadData()
            
        }) { (err) in
            self.hideTableViewBottomIndicator(tableView: self.movieListTableView)
            print(err)
        }
    }
    
    private func upComingLoadMoreData(page: Int) {
        showTableViewBottomIndicator(tableView: movieListTableView)
        UserDataModel.shared.getUpcomingMovieList(page: page, success: {
            self.hideTableViewBottomIndicator(tableView: self.movieListTableView)
            
            self.upcomingMovieList.append(objectsIn: UserDataModel.shared.upComingVO.results)
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
        if selectedTab == 0 {
            return nowPlayingMovieList.count
        } else {
            return upcomingMovieList.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.identifier, for: indexPath) as! MovieListTableViewCell
        if selectedTab == 0 {
            cell.movie = nowPlayingMovieList[indexPath.row]
            cell.delegate = self
            cell.index = nowPlayingMovieList[indexPath.row].id
            return cell
        } else {
            cell.movie = upcomingMovieList[indexPath.row]
            cell.delegate = self
//            cell.favouriteState = UserDataModel.shared.upComingFavouriteStateList[indexPath.row]
            cell.index = indexPath.row
            return cell
        }
        
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedTab == 0 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: DetailViewController.identifier) as DetailViewController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            vc.movieID = nowPlayingMovieList[indexPath.row].id
//            vc.favouriteState = UserDataModel.shared.favouriteStateList[indexPath.row]
            vc.tableViewCellIndex = indexPath.row
            vc.segmentedControlIndex = selectedTab
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: DetailViewController.identifier) as DetailViewController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            vc.movieID = upcomingMovieList[indexPath.row].id
            vc.favouriteState = UserDataModel.shared.upComingFavouriteStateList[indexPath.row]
            vc.tableViewCellIndex = indexPath.row
            vc.segmentedControlIndex = selectedTab
        }
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        // check tableview reachs end method
        if movieListTableView.contentOffset.y >= (movieListTableView.contentSize.height - movieListTableView.frame.size.height) {
            if selectedTab == 0 {
                if page <= (RealmHelper.shared.retrieveNowPlayingMovie().first?.totalPages ?? 0) {
                    page += 1
                    loadMoreData(page: page)
                }
            } else {
                if upcomingPage <= (UserDataModel.shared.upComingVO.totalPages) {
                    upcomingPage += 1
                    upComingLoadMoreData(page: upcomingPage)
                }
            }
        }
        
    }
    
}
    
    extension MainViewController: MovieListItemDelegate {
        func onTapFavourite(index: Int, state: Bool) {
            if selectedTab == 0 {
                RealmHelper.shared.updateFavouriteStae(movieId: index, favouriteState: state)
                movieListTableView.reloadData()
            } else {
                UserDataModel.shared.upComingFavouriteStateList[index] = state
                movieListTableView.reloadData()
            }
        }
}



