//
//  AssetsManager.swift
//  Imgur
//
//  Created by Ravi Prakash on 20/04/16.
//  Copyright © 2016 Ravi Prakash. All rights reserved.
//

import UIKit

public enum Image: String {
    case Grid = "grid"
    case List = "list"
    case Staggerd = "staggerd"
    case PlaceHolder = "lightGray"
    case UVote = "upVote"
    case DVote = "downVote"
    case Score = "score"
    case Info = "info"
    case Config = "config"
}
class AssetsManager: NSObject {
    static func getImage(imageName : Image) -> UIImage {
        let image = UIImage(named: imageName.rawValue)
        return image!
    }
    
    static func getTempletImage(imageName : Image) -> UIImage {
        let image = AssetsManager.getImage(imageName)
        let templateImage = image.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        return templateImage
    }
}
