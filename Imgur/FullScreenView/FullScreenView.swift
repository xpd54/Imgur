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
    init(frame: CGRect, image: UIImage, imageInformation:NSDictionary) {
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
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false

        let description = UITextView()
        description.translatesAutoresizingMaskIntoConstraints = false
        description.editable = false
        description.backgroundColor = UIColor.lightGrayColor()

        let scoreView = UIView()
        scoreView.translatesAutoresizingMaskIntoConstraints = false
        scoreView.backgroundColor = UIColor.darkGrayColor()

        let upVoteIcon = UIImageView(image: AssetsManager.getImage(Image.UVote))
        upVoteIcon.translatesAutoresizingMaskIntoConstraints = false
        let upVoteNumber = UILabel()
        upVoteNumber.text = self.upVote

        let downVoteIcon = UIImageView(image: AssetsManager.getImage(Image.DVote))
        downVoteIcon.translatesAutoresizingMaskIntoConstraints = false
        let downVoteNumber = UILabel()
        downVoteNumber.text = self.downVote
        
        let scoreIcon = UIImageView(image: AssetsManager.getImage(Image.Score))
        scoreIcon.translatesAutoresizingMaskIntoConstraints = false
        let scoreNumber = UILabel()
        scoreNumber.text = self.score

        // Set up ScoreView where upvote, downVote, title and Score lies
        
        scoreView.addSubview(titleView)
        scoreView.addSubview(upVoteIcon)
        scoreView.addSubview(downVoteIcon)
        scoreView.addSubview(scoreIcon)
        
        let views = ["titleView" : titleView,
                     "upVoteIcon" : upVoteIcon,
                     "upVoteNumber" : upVoteNumber,
                     "downVoteIcon" : downVoteIcon,
                     "downVoteNumber" : downVoteNumber,
                     "scoreIcon" : scoreIcon,
                     "scoreNumber" : scoreNumber]
        let hcStringTitle = "H:|-1-[titleView]-1-|"
        let vcStringTitle = "V:|-1-[titleView]"
        let hcStringUpVote = "H:|-1-[upVoteIcon]-1-[upVoteNumber]-[downVoteIcon]-1-[downVoteNumber]-[scoreIcon]-1-[scoreNumber]-1-|"
        let vcStringUpVote = "V:[titleView]-1-[upVoteIcon]-1|"
        let vcStringUpVoteNumber = "V:[titleView]-1-[upVoteNumber]-1-|"
        let vcStringDownVote = "V:[titleView]-1-[downVoteIcon]-1-|"
        let vcStringDownvoteNumber = "V:[titleView]-1-[downVoteNumber]-1-|"
        let vcStringScore = "V:[titleView]-1-[scoreIcon]-1-|"
        let vcStringScoreNumber = "V:[titleView]-1-[scoreNumber]-1-|"
        
        let titleHorizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat(hcStringTitle, options: NSLayoutFormatOptions.AlignAllTop, metrics: nil, views: views)
        let titleVerticalConstratints = NSLayoutConstraint.constraintsWithVisualFormat(vcStringTitle, options: NSLayoutFormatOptions.AlignAllLeft, metrics: nil, views: views)

        let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat(hcStringUpVote, options: NSLayoutFormatOptions.AlignAllLeft, metrics: nil, views: views)
        let vcUpVote = NSLayoutConstraint.constraintsWithVisualFormat(vcStringUpVote, options: NSLayoutFormatOptions.AlignAllLeft, metrics: nil, views: views)
        let vcUpVoteNumber = NSLayoutConstraint.constraintsWithVisualFormat(vcStringUpVoteNumber, options: NSLayoutFormatOptions.AlignAllLeft, metrics: nil, views: views)
        let vcDownVote = NSLayoutConstraint.constraintsWithVisualFormat(vcStringDownVote, options: NSLayoutFormatOptions.AlignAllLeft, metrics: nil, views: views)
        let vcDownVoteNumber = NSLayoutConstraint.constraintsWithVisualFormat(vcStringDownvoteNumber, options: NSLayoutFormatOptions.AlignAllLeft, metrics: nil, views: views)
        let vcScore = NSLayoutConstraint.constraintsWithVisualFormat(vcStringScore, options: NSLayoutFormatOptions.AlignAllLeft, metrics: nil, views: views)
        let vcScoreNumber = NSLayoutConstraint.constraintsWithVisualFormat(vcStringScoreNumber, options: NSLayoutFormatOptions.AlignAllLeft, metrics: nil, views: views)
        scoreView.addConstraints(titleHorizontalConstraints)
        scoreView.addConstraints(titleVerticalConstratints)
        scoreView.addConstraints(horizontalConstraints)
        scoreView.addConstraints(vcUpVote)
        scoreView.addConstraints(vcUpVoteNumber)
        scoreView.addConstraints(vcDownVote)
        scoreView.addConstraints(vcDownVoteNumber)
        scoreView.addConstraints(vcScore)
        scoreView.addConstraints(vcScoreNumber)
        
        //Set ScoreView to main view 
        self.addSubview(scoreView)
        let mainViews = ["scoreView" : scoreView]
        let hcStringScoreView = "H:|-1-[scoreView]-1-|"
        let vcStringScoreView = "V:|-1-[scoreView]-1-|"
        let horizontalConstraintMainView = NSLayoutConstraint.constraintsWithVisualFormat(hcStringScoreView, options: NSLayoutFormatOptions.AlignAllBottom, metrics: nil, views: mainViews)
        let verticalConstraintMainView = NSLayoutConstraint.constraintsWithVisualFormat(vcStringScoreView, options: NSLayoutFormatOptions.AlignAllLeft, metrics: nil, views: mainViews)
        self.addConstraints(horizontalConstraintMainView)
        self.addConstraints(verticalConstraintMainView)
    }
}
