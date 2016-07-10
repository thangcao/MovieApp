//
//  HandleUtil.swift
//  MovieApp
//
//  Created by Cao Thắng on 7/9/16.
//  Copyright © 2016 thangcao. All rights reserved.
//

import Foundation
import SystemConfiguration
import UIKit
import AFNetworking
struct HandleUtil {
    static func isConnectToNetwork() -> Bool {
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
            SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, UnsafePointer($0))
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        let isReachable = flags == .Reachable
        let needsConnection = flags == .ConnectionRequired
        
        return isReachable && !needsConnection
    }
    static func convertDateFormater(date: String) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let timeStamp = dateFormatter.dateFromString(date)
        let dateString = dateFormatter.stringFromDate(timeStamp!)
        return (dateString)
    }
    static func loadingImageHighToLowResolution (pathImageUrl: String, imageView: UIImageView) {
        let highResPosterUrl = HIGH_RESOLUTION_BASE_URL + pathImageUrl
        let highResImageRequest = NSURLRequest(URL: NSURL(string: highResPosterUrl)!)
        let lowResPosterUrl = LOW_RESOLUTION_BASE_URL + pathImageUrl
        let lowResImageRequest = NSURLRequest(URL: NSURL(string: lowResPosterUrl)!)
        imageView.setImageWithURLRequest(lowResImageRequest, placeholderImage: nil, success: { (lowResImageRequest, lowResImageResponse, lowResImage) in
            imageView.alpha = 0.0
            imageView.image = lowResImage
            UIView.animateWithDuration(0.3, animations: { _ -> Void in
                imageView.alpha = 1.0
                }, completion: { sucess in
                    imageView.setImageWithURLRequest(highResImageRequest, placeholderImage: lowResImage, success: { (highResImageRequest, highResImageResponse, highResImage) in
                        imageView.image = highResImage
                        }, failure: { (request, response, image) in
                            
                    })
            })
            }, failure: { (request, response, image) in
        })
    }
}
