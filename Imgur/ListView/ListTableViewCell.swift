//
//  ListTableViewCell.swift
//  Imgur
//
//  Created by Ravi Prakash on 28/04/16.
//  Copyright © 2016 Ravi Prakash. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    var titleLabel: UILabel!
    var descriptionLable : UILabel!
    var cellImageView: UIImageView!
    var progressView: UIProgressView!
    private let imageViewHeight = 94.0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        cellImageView = UIImageView()
        cellImageView.backgroundColor = UIColor.blackColor()
        titleLabel = UILabel()
        progressView = UIProgressView()
        cellImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.progressTintColor = UIColor.greenColor()
        cellImageView.contentMode = UIViewContentMode.ScaleAspectFit
        cellImageView.clipsToBounds = true
        titleLabel.font = UIFont.boldSystemFontOfSize(12)
        titleLabel.textAlignment = .Left
        titleLabel.numberOfLines = 0
        titleLabel.backgroundColor = UIColor.clearColor()

        descriptionLable = UILabel()
        descriptionLable.translatesAutoresizingMaskIntoConstraints = false
        descriptionLable.font  = UIFont.systemFontOfSize(10)
        descriptionLable.textAlignment = .Left
        descriptionLable.numberOfLines = 0
        descriptionLable.backgroundColor = UIColor.clearColor()
        contentView.addSubview(descriptionLable)

        contentView.addSubview(titleLabel)
        contentView.bringSubviewToFront(titleLabel)
        contentView.addSubview(cellImageView)
        cellImageView.addSubview(progressView)
        let views = ["imageView" : cellImageView,
                     "titleLabel" : titleLabel,
                     "progressView" : progressView,
                     "descriptionLable" : descriptionLable]
        let hcImageString = "H:|-2-[imageView(\(imageViewHeight))]-2-[titleLabel(descriptionLable)]-|"
        let vcImageString = "V:|-2-[imageView]-2-|"
        let vcDescriptionLable = "V:|-2-[titleLabel]-1-[descriptionLable(titleLabel)]-2-|"
        let hcProgressViewString = "H:|-1-[progressView]-1-|"
        let vcProgressViewString = "V:[progressView]-1-|"

        let vcDescription = NSLayoutConstraint.constraintsWithVisualFormat(vcDescriptionLable,
                                                                           options: NSLayoutFormatOptions.AlignAllLeft,
                                                                           metrics: nil,
                                                                           views: views)

        let progressViewHorizontalConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hcProgressViewString,
                                                                                              options: NSLayoutFormatOptions.AlignAllBottom,
                                                                                              metrics: nil,
                                                                                              views: views)
        let progressViewVerticalConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vcProgressViewString,
                                                                                            options: NSLayoutFormatOptions.AlignAllLeft,
                                                                                            metrics: nil,
                                                                                            views: views)
        
        let imageVerticalConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vcImageString,
                                                                                     options: NSLayoutFormatOptions.AlignAllLeft,
                                                                                     metrics: nil,
                                                                                     views: views)
        let imageHorizontalConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hcImageString,
                                                                                       options: NSLayoutFormatOptions.AlignAllTop,
                                                                                       metrics: nil,
                                                                                       views: views)
        contentView.addConstraints(imageVerticalConstraint)
        contentView.addConstraints(imageHorizontalConstraint)
        cellImageView.addConstraints(progressViewHorizontalConstraint)
        cellImageView.addConstraints(progressViewVerticalConstraint)
        contentView.addConstraints(vcDescription)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
