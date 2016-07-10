//
//  Movie.swift
//  MovieApp
//
//  Created by Cao Thắng on 7/7/16.
//  Copyright © 2016 thangcao. All rights reserved.
//

import Foundation

struct Movie {
    var posterPath : String!
    var backdropPath: String?
    var overView: String!
    var releaseDate: String?
    var id: Int!
    var title: String!
    var voteCount: Int!
    var voteAverage: Double!
    init(data: NSDictionary){
        //Set updata
        posterPath = data["poster_path"] as! String
        if let backdropPathTemp = data["backdrop_path"] as? String {
             backdropPath = backdropPathTemp
        }
        else {
            backdropPath = posterPath
        }
        
        overView = data["overview"] as! String
        releaseDate = data["release_date"] as? String
        id = data["id"] as! Int
        title = data["original_title"] as! String
        voteCount = data["vote_count"] as! Int
        voteAverage = data["vote_average"] as! Double
    }
}