//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by Cao Thắng on 7/8/16.
//  Copyright © 2016 thangcao. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    var movie: Movie!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var movieOverView: UILabel!
    
    @IBOutlet weak var gradientViewInfo: UIView!
    @IBOutlet weak var movieBackdropImage: UIImageView!
    @IBOutlet weak var imdb: UIButton!
    @IBOutlet weak var movieIMDB: UIButton!
    @IBOutlet weak var movieName: UILabel!
    
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var movieVoteCount: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var infoView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        initAndLoadDataToView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension MovieDetailViewController {
    func initAndLoadDataToView(){
        gradientView = CustomViewUtil.configViewGradientBlack(gradientView)
        gradientViewInfo = CustomViewUtil.configViewGradientBlack(gradientViewInfo)
        imdb = CustomViewUtil.configViewToCirle(imdb) as! UIButton
        movieName.text = movie.title
        movieName.sizeToFit()
        movieReleaseDate.text = movie.releaseDate
        movieReleaseDate.sizeToFit()
        movieOverView.text = movie.overView
        movieOverView.sizeToFit()
        movieIMDB.setTitle("\(movie.voteAverage)", forState: .Normal)
        movieVoteCount.text = "\(movie.voteCount)"
        movieVoteCount.sizeToFit()
        // Set Content Size for ScrollView
        infoView.frame.size.height = movieOverView.frame.size.height + infoView.frame.size.height/2
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: infoView.frame.origin.y + infoView.frame.size.height)
        
        // Loading image poster path
        if let pathUrl = movie.posterPath{
           HandleUtil.loadingImageHighToLowResolution(pathUrl, imageView: movieImage)
        }
        if let pathUrl = movie.backdropPath {
            let imageUrl = NSURL(string: BASE_IMAGE_URL + pathUrl)
            movieBackdropImage.setImageWithURL(imageUrl!)
        }
        
    }
}
