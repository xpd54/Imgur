//
//  FullScreenView.swift
//  Imgur
//
//  Created by Ravi Prakash on 25/04/16.
//  Copyright © 2016 Ravi Prakash. All rights reserved.
//

import UIKit

class FullScreenView: UIView {
    var image : UIImage!
    var title : String!
    var imageDescription: String!
    var upVote : String!
    var downVote : String!
    var score : String!
    var height : String!
    var width : String!
    var imageView : UIImageView!
    init(frame: CGRect,image: UIImage, imageInformation:NSDictionary) {
        super.init(frame: frame)
        self.setUpView(image, imageInformation: imageInformation)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView(image:UIImage, imageInformation:NSDictionary) {
        self.backgroundColor = UIColor.lightGrayColor()
        self.image = image
        self.title = imageInformation.objectForKey(DataType.Title.rawValue) as! String
        if let dis = imageInformation.objectForKey(DataType.Description.rawValue) {
            self.imageDescription = dis as! String
        }
        self.upVote = imageInformation.objectForKey(DataType.UpVote.rawValue) as! String
        self.downVote = imageInformation.objectForKey(DataType.DownVote.rawValue) as! String
        self.score = imageInformation.objectForKey(DataType.Score.rawValue) as! String
        self.height = imageInformation.objectForKey(DataType.Height.rawValue) as! String
        self.width = imageInformation.objectForKey(DataType.Width.rawValue) as! String

        let titleView = UILabel()
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.text = title
        titleView.textAlignment = .Left
        titleView.textColor = UIColor.whiteColor()
        titleView.font = UIFont.boldSystemFontOfSize(18.0)
        imageView = UIImageView(image: image)
        imageView.contentMode = .ScaleAspectFit
        imageView.backgroundColor = UIColor.blackColor()
        imageView.translatesAutoresizingMaskIntoConstraints = false

        let description = UITextView()
        description.text = imageDescription
        description.translatesAutoresizingMaskIntoConstraints = false
        description.editable = false
        description.backgroundColor = UIColor.lightGrayColor()

        let scoreView = UIView()
        scoreView.translatesAutoresizingMaskIntoConstraints = false
        scoreView.backgroundColor = UIColor.darkGrayColor()

        let upVoteIcon = UIImageView(image: AssetsManager.getImage(Image.UVote))
        upVoteIcon.translatesAutoresizingMaskIntoConstraints = false
        let upVoteNumber = UILabel()
        upVoteNumber.translatesAutoresizingMaskIntoConstraints = false
        upVoteNumber.text = self.upVote

        let downVoteIcon = UIImageView(image: AssetsManager.getImage(Image.DVote))
        downVoteIcon.translatesAutoresizingMaskIntoConstraints = false
        let downVoteNumber = UILabel()
        downVoteNumber.translatesAutoresizingMaskIntoConstraints = false
        downVoteNumber.text = self.downVote

        let scoreIcon = UIImageView(image: AssetsManager.getImage(Image.Score))
        scoreIcon.translatesAutoresizingMaskIntoConstraints = false
        let scoreNumber = UILabel()
        scoreNumber.translatesAutoresizingMaskIntoConstraints = false
        scoreNumber.text = self.score

        // Set up ScoreView where upvote, downVote, title and Score lies

        scoreView.addSubview(titleView)
        scoreView.addSubview(upVoteIcon)
        scoreView.addSubview(upVoteNumber)
        scoreView.addSubview(downVoteIcon)
        scoreView.addSubview(downVoteNumber)
        scoreView.addSubview(scoreIcon)
        scoreView.addSubview(scoreNumber)

        let views = ["titleView" : titleView,
                     "upVoteIcon" : upVoteIcon,
                     "upVoteNumber" : upVoteNumber,
                     "downVoteIcon" : downVoteIcon,
                     "downVoteNumber" : downVoteNumber,
                     "scoreIcon" : scoreIcon,
                     "scoreNumber" : scoreNumber]
        let hcStringTitle = "H:|-1-[titleView]-1-|"
        let vcStringTitle = "V:|-1-[titleView]-0-[upVoteIcon]-1-|"
        let hcStringUpVote = "H:|-1-[upVoteIcon]-1-[upVoteNumber(downVoteNumber)]-[downVoteIcon]-1-[downVoteNumber(scoreNumber)]-[scoreIcon]-1-[scoreNumber]-1-|"
        let titleHorizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat(hcStringTitle, options: NSLayoutFormatOptions.AlignAllTop, metrics: nil, views: views)
        let titleVerticalConstratints = NSLayoutConstraint.constraintsWithVisualFormat(vcStringTitle, options: NSLayoutFormatOptions.AlignAllLeft, metrics: nil, views: views)

        let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat(hcStringUpVote, options: NSLayoutFormatOptions.AlignAllBottom, metrics: nil, views: views)
        scoreView.addConstraints(titleHorizontalConstraints)
        scoreView.addConstraints(titleVerticalConstratints)
        scoreView.addConstraints(horizontalConstraints)

        //Set ScoreView to main view
        let widthOFScreen = UIScreen.mainScreen().bounds.width
        let heightOfImageView = (Int(height)! * Int(widthOFScreen)) / Int(width)!

        self.addSubview(scoreView)
        self.addSubview(imageView)
        self.addSubview(description)
        let mainViews = ["scoreView" : scoreView,
                         "imageView" : imageView,
                         "description" : description]
        let hcStringScoreView = "H:|-1-[scoreView]-1-|"
        let hcStringImageView = "H:|-1-[imageView]-1-|"
        let vcStringScoreView = "V:|-1-[scoreView]-1-[imageView(\(heightOfImageView))]-1-[description]-1-|"
        let hcStringDescription = "H:|-1-[description]-1-|"

        let hcScoreView = NSLayoutConstraint.constraintsWithVisualFormat(hcStringScoreView, options: NSLayoutFormatOptions.AlignAllTop, metrics: nil, views: mainViews)
        let hcImageView = NSLayoutConstraint.constraintsWithVisualFormat(hcStringImageView, options: NSLayoutFormatOptions.AlignAllTop, metrics: nil, views: mainViews)
        let hcDescription = NSLayoutConstraint.constraintsWithVisualFormat(hcStringDescription, options: NSLayoutFormatOptions.AlignAllBottom, metrics: nil, views: mainViews)
        let vcScoreView = NSLayoutConstraint.constraintsWithVisualFormat(vcStringScoreView, options: NSLayoutFormatOptions.AlignAllLeft, metrics: nil, views: mainViews)
        self.addConstraints(hcScoreView)
        self.addConstraints(hcImageView)
        self.addConstraints(hcDescription)
        self.addConstraints(vcScoreView)
    }
}
