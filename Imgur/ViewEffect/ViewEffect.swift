//
//  ViewEffect.swift
//  Imgur
//
//  Created by Ravi Prakash on 23/04/16.
//  Copyright © 2016 Ravi Prakash. All rights reserved.
//

import UIKit
class ViewEffect: NSObject {
    class func addShadowEffect(view: UIView, opacity: Float ) {
        view.layer.shadowColor = UIColor.blackColor().CGColor
        view.layer.shadowOpacity = opacity
        view.layer.shadowOffset = CGSizeZero
        view.layer.shadowRadius = 3.0
    }
}