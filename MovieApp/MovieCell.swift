//
//  MovieCell.swift
//  MovieApp
//
//  Created by Cao Thắng on 7/6/16.
//  Copyright © 2016 thangcao. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var imageMovie: UIImageView!
    
    @IBOutlet weak var imdbNumber: UIButton!
    @IBOutlet weak var gradientView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imdbNumber = CustomViewUtil.configViewToCirle(imdbNumber) as! UIButton
        gradientView = CustomViewUtil.configViewGradientBlack(gradientView)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
