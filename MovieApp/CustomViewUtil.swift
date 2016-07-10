//
//  CustomViewUtil.swift
//  MovieApp
//
//  Created by Cao Thắng on 7/10/16.
//  Copyright © 2016 thangcao. All rights reserved.
//

import Foundation
import UIKit
struct CustomViewUtil {
    static func configViewGradientBlack(view: UIView) -> UIView{
        let gradientView = view
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = gradientView.bounds
        gradient.colors = [UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.0).CGColor,UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.8).CGColor]
        gradientView.layer.insertSublayer(gradient, atIndex: 0)
        return gradientView
    }
    /*
     * This function use make view to be a circle (option: width = height)
     */
    static func configViewToCirle(view: UIView) -> UIView{
        if (view.frame.size.width != view.frame.size.height){
            return view
        }
        let circleView = view
        circleView.layer.cornerRadius =
            circleView.frame.size.width / 2
        circleView.clipsToBounds = true
        circleView.layer.borderColor = UIColor.whiteColor()
            .CGColor
        circleView.layer.borderWidth = 1
        return circleView
    }
}