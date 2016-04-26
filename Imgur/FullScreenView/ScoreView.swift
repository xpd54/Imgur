//
//  ScoreView.swift
//  Imgur
//
//  Created by Ravi Prakash on 26/04/16.
//  Copyright © 2016 Ravi Prakash. All rights reserved.
//

import UIKit

class ScoreView: UIView {
    var title : String!
    var upVote : String!
    var downVote : String!
    var score : String!
    init(frame: CGRect, imageInformation:NSDictionary) {
        super.init(frame: frame)
        self.setUpView(imageInformation)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpView(imageInformation:NSDictionary) {
        self.backgroundColor = UIColor.lightGrayColor()
        self.title = imageInformation.objectForKey(DataType.Title.rawValue) as! String
        self.upVote = imageInformation.objectForKey(DataType.UpVote.rawValue) as! String
        self.downVote = imageInformation.objectForKey(DataType.DownVote.rawValue) as! String
        self.score = imageInformation.objectForKey(DataType.Score.rawValue) as! String

        let titleView = UILabel()
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.text = title
        titleView.textAlignment = .Left
        titleView.textColor = UIColor.whiteColor()
        titleView.font = UIFont.boldSystemFontOfSize(18.0)

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
        self.addSubview(scoreView)

        let mainViews = ["scoreView" : scoreView]
        let hcStringScoreView = "H:|-0-[scoreView]-0-|"
        let vcStringScoreView = "V:|-0-[scoreView]-0-|"
        let hcScoreView = NSLayoutConstraint.constraintsWithVisualFormat(hcStringScoreView, options: NSLayoutFormatOptions.AlignAllBottom, metrics: nil, views: mainViews)
        let vcScoreView = NSLayoutConstraint.constraintsWithVisualFormat(vcStringScoreView, options: NSLayoutFormatOptions.AlignAllLeft, metrics: nil, views: mainViews)
        self.addConstraints(hcScoreView)
        self.addConstraints(vcScoreView)
    }
}
