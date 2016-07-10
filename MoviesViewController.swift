//
//  MoviesViewController.swift
//  MovieApp
//
//  Created by Cao Thắng on 7/5/16.
//  Copyright © 2016 thangcao. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD
class MoviesViewController: BaseViewLoadDataController {
   
    @IBOutlet weak var viewA: UILabel!
    @IBOutlet weak var networkErrorLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initSearchBar()
        initView()
        loadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPathForCell(cell) {
            let controller = segue.destinationViewController as! MovieDetailViewController
            controller.movie = self.filterMovies[indexPath.row]
        }
        
    }
    
}
extension MoviesViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(filterMovies.count)
        return filterMovies.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! MovieCell
        let movie = filterMovies[indexPath.row]
        if let pathUrl = movie.posterPath {
            let imageUrl = NSURL(string: BASE_IMAGE_URL + pathUrl)
            let imageRequest = NSURLRequest(URL: imageUrl!)
            cell.imageMovie.setImageWithURLRequest(
                imageRequest,
                placeholderImage: nil,
                success: { (imageRequest, imageResponse, image) -> Void in
                    
                    // imageResponse will be nil if the image is cached
                    if imageResponse != nil {
                        print("Image was NOT cached, fade in image")
                        cell.imageMovie.alpha = 0.0
                        cell.imageMovie.image = image
                        UIView.animateWithDuration(0.7, animations: { () -> Void in
                            cell.imageMovie.alpha = 1.0
                        })
                    } else {
                        print("Image was cached so just update the image")
                        cell.imageMovie.image = image
                    }
                },
                failure: { (imageRequest, imageResponse, error) -> Void in
                    // do something for the failure condition
            })
        } else {
            cell.imageMovie.image = nil
        }
        cell.title.text = movie.title
        cell.imdbNumber.setTitle("\(movie.voteAverage)", forState: .Normal)
        return cell
    }
}
extension MoviesViewController : UISearchBarDelegate , UISearchDisplayDelegate{
    func filterMoviesContent (searchText: String){
        if (searchText.isEmpty){
            filterMovies = movies
        } else {
            filterMovies = self.movies.filter { movie in
                return movie.title.lowercaseString.containsString(searchText.lowercaseString)
            }
            
        }
        self.tableView.reloadData()
    }
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        filterMoviesContent(searchBar.text!)
    }
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchBars.showsCancelButton = true
    }
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchBars.showsCancelButton = false
    }
}
// Custom function
extension MoviesViewController {
    func initSearchBar() {
        searchBars.showsCancelButton = false
        searchBars.placeholder = "Enter your search here"
        searchBars.delegate = self
        self.navigationItem.titleView = searchBars
    }
    func initView(){
        tableView.dataSource = self
        tableView.delegate = self
        refreshControl.attributedTitle = NSAttributedString(string: PULL_TO_REFESH)
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
    }
    func loadData() {
        if (!HandleUtil.isConnectToNetwork()){
            networkErrorLabel.hidden = false
            refreshControl.endRefreshing()
        }else {
            networkErrorLabel.hidden = true
            loadData(MOVIE_NOW_PLAYING, tableView: self.tableView, refreshControl: refreshControl)
        }
    }
    func refreshControlAction(refreshControl: UIRefreshControl) {
        loadData()
    }
}

