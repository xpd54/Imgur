//
//  GridCollectionViewCell.swift
//  Imgur
//
//  Created by Ravi Prakash on 23/04/16.
//  Copyright © 2016 Ravi Prakash. All rights reserved.
//

import UIKit

class GridCollectionViewCell: UICollectionViewCell {
    var textLabel: UILabel!
    var imageView: UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView()
        textLabel = UILabel()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.clipsToBounds = true
        textLabel.font = UIFont.systemFontOfSize(10)
        textLabel.textAlignment = .Center
        textLabel.numberOfLines = 0
        textLabel.backgroundColor = UIColor.clearColor()
        imageView.addSubview(textLabel)
        imageView.bringSubviewToFront(textLabel)
        contentView.addSubview(imageView)
        contentView.backgroundColor = UIColor.darkGrayColor()
        let labelHeight = frame.size.height/6
        let views = ["imageView" : imageView,
                     "textLabel" : textLabel]
        let hcImageString = "H:|-1-[imageView]-1-|"
        let vcImageString = "V:|-1-[imageView]-1-|"
        let hcLabelString = "H:|-1-[textLabel]-1-|"
        let vcLabelString = "V:[textLabel(\(labelHeight))]-0-|"
        
        let imageVerticalConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vcImageString, options: NSLayoutFormatOptions.AlignAllLeft, metrics: nil, views: views)
        let imageHorizontalConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hcImageString, options: NSLayoutFormatOptions.AlignAllTop, metrics: nil, views: views)
        
        let labelHorizontalConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hcLabelString, options: NSLayoutFormatOptions.AlignAllBottom, metrics: nil, views: views)
        let labelVerticalConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vcLabelString, options: NSLayoutFormatOptions.AlignAllLeft, metrics: nil, views: views)
        contentView.addConstraints(imageVerticalConstraint)
        contentView.addConstraints(imageHorizontalConstraint)
        imageView.addConstraints(labelHorizontalConstraint)
        imageView.addConstraints(labelVerticalConstraint)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}