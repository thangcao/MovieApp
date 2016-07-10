//
//  BaseViewLoadDataController.swift
//  MovieApp
//
//  Created by Cao Thắng on 7/10/16.
//  Copyright © 2016 thangcao. All rights reserved.
//

import UIKit
import MBProgressHUD
class BaseViewLoadDataController: UIViewController {
    var movies = [Movie]()
    var filterMovies = [Movie]()
    lazy var searchBars:UISearchBar = UISearchBar()
    let refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension BaseViewLoadDataController {
    func loadData(movieApi: String, tableView: UITableView, refreshControl: UIRefreshControl){
        let url = NSURL(string: "\(BASE_URL)\(movieApi)?api_key=\(API_KEY)")
        let request = NSURLRequest(
            URL: url!,
            cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData,
            timeoutInterval: 10)
        
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate: nil,
            delegateQueue: NSOperationQueue.mainQueue()
        )
        // Display HUD right before the request is made
        let progressHUD = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        progressHUD.labelText = LOADING_DATA
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(request,
                                                                     completionHandler: { (dataOrNil, response, error) in
                                                                        if let data = dataOrNil {
                                                                            if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                                                                                data, options:[]) as? NSDictionary {
                                                                                if let moviesJson = responseDictionary["results"] as? [NSDictionary] {
                                                                                    for movieJson in moviesJson {
                                                                                        let movie = Movie(data: movieJson)
                                                                                        self.movies.append(movie)
                                                                                    }
                                                                                    self.filterMovies = self.movies
                                                                                }
                                                                                MBProgressHUD.hideHUDForView(self.view, animated: true)
                                                                                tableView.reloadData()
                                                                                refreshControl.endRefreshing()
                                                                            }
                                                                        }
                                                                        
        });
        task.resume()
    }
}
