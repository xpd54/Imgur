//
//  BigImageView.swift
//  Imgur
//
//  Created by Ravi Prakash on 26/04/16.
//  Copyright © 2016 Ravi Prakash. All rights reserved.
//

import UIKit

class BigImageView: UIView {
    var image : UIImage!
    var height : String!
    var width : String!
    var imageView : UIImageView!

    init(frame: CGRect, image: UIImage,imageInformation:NSDictionary) {
        super.init(frame: frame)
        self.setUpView(image,imageInformation: imageInformation)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView(image: UIImage, imageInformation: NSDictionary) {
        self.image = image
        imageView = UIImageView(image: image)
        imageView.contentMode = .ScaleAspectFit
        imageView.backgroundColor = UIColor.blackColor()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
        let mainView = ["imageView" : imageView]
        let hcString = "H:|-0-[imageView]-0-|"
        let vcString = "V:|-0-[imageView]-0-|"
        let hcImageView = NSLayoutConstraint.constraintsWithVisualFormat(hcString, options: NSLayoutFormatOptions.AlignAllBottom, metrics: nil, views: mainView)
        let vcImageView = NSLayoutConstraint.constraintsWithVisualFormat(vcString, options: NSLayoutFormatOptions.AlignAllLeft, metrics: nil, views: mainView)
        self.addConstraints(vcImageView)
        self.addConstraints(hcImageView)
    }
}
