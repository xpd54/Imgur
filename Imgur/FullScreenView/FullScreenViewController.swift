//
//  FullScreenViewController.swift
//  Imgur
//
//  Created by Ravi Prakash on 26/04/16.
//  Copyright © 2016 Ravi Prakash. All rights reserved.
//

import UIKit

class FullScreenViewController: UIViewController {
    var scrollView : UIScrollView!
    var scoreView : ScoreView!
    var imageInformation : NSDictionary!
    var contentView : UIView!
    var imageView : UIImageView!
    var image : UIImage!
    var descriptionView : UITextView!
    var imageDescription: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        super.loadView()
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor.greenColor()
        self.view.addSubview(scrollView)

        contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)

        let informationDict = [DataType.Title.rawValue : "Title",
                               DataType.Description.rawValue : "Description a quick dog jums ober the lazy dog ye he did so what you wanna do do exactly that's ok",
                               DataType.UpVote.rawValue: "10",
                               DataType.DownVote.rawValue: "20",
                               DataType.Score.rawValue: "12",
                               DataType.Height.rawValue: "150",
                               DataType.Width.rawValue: "150"]
        scoreView = ScoreView(frame: self.view.frame, imageInformation: informationDict)
        scoreView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(scoreView)
        
        imageView = UIImageView(image: AssetsManager.getImage(Image.Test))
        imageView.contentMode = .ScaleAspectFit
        imageView.backgroundColor = UIColor.blackColor()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        
        descriptionView = UITextView()
        if let dis = informationDict[DataType.Description.rawValue] {
            self.imageDescription = dis
        }
        descriptionView.text = imageDescription
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        descriptionView.editable = false
        descriptionView.selectable = false
        descriptionView.backgroundColor = UIColor.lightGrayColor()
        contentView.addSubview(descriptionView)
        
        let views = ["contentView" : contentView,
                     "scoreView" : scoreView,
                     "scrollView" : scrollView,
                     "imageView" : imageView,
                     "descriptionView" : descriptionView]
        let hcStringScrollView = "H:|-0-[scrollView]-0-|"
        let vcStringScrollView = "V:|-0-[scrollView]-0-|"
        let hcScrollView = NSLayoutConstraint.constraintsWithVisualFormat(hcStringScrollView,
                                                                          options: NSLayoutFormatOptions.AlignAllBottom,
                                                                          metrics: nil,
                                                                          views: views)
        let vcScrollView = NSLayoutConstraint.constraintsWithVisualFormat(vcStringScrollView,
                                                                          options: NSLayoutFormatOptions.AlignAllLeft,
                                                                          metrics: nil,
                                                                          views: views)
        self.view.addConstraints(vcScrollView)
        self.view.addConstraints(hcScrollView)

        let hcStringScoreView = "H:|-0-[scoreView(imageView)]-0-|"
        let vcStringScoreView = "V:|-0-[scoreView(49)]"
        let hcScoreView = NSLayoutConstraint.constraintsWithVisualFormat(hcStringScoreView,
                                                                         options: NSLayoutFormatOptions.AlignAllTop,
                                                                         metrics: nil,
                                                                         views: views)
        let vcScoreView = NSLayoutConstraint.constraintsWithVisualFormat(vcStringScoreView,
                                                                         options: NSLayoutFormatOptions.AlignAllLeft,
                                                                         metrics: nil,
                                                                         views: views)
        contentView.addConstraints(hcScoreView)
        contentView.addConstraints(vcScoreView)

        let vcStringImageView = "V:|-49-[imageView]-0-[descriptionView]-0-|"
        let vcImageView = NSLayoutConstraint.constraintsWithVisualFormat(vcStringImageView, options: NSLayoutFormatOptions.AlignAllLeft, metrics: nil, views: views)
        contentView.addConstraints(vcImageView)
        
        let hcStringDescription = "H:|-0-[descriptionView]-0-|"
        let vcStringDescription = "V:[imageView]-0-[descriptionView]-0-|"
        let hcDescriptionView = NSLayoutConstraint.constraintsWithVisualFormat(hcStringDescription,
                                                                               options: NSLayoutFormatOptions.AlignAllBottom,
                                                                               metrics: nil,
                                                                               views: views)
        let vcDescriptionView = NSLayoutConstraint.constraintsWithVisualFormat(vcStringDescription,
                                                                               options: NSLayoutFormatOptions.AlignAllLeft,
                                                                               metrics: nil,
                                                                               views: views)
//        contentView.addConstraints(vcDescriptionView)
        contentView.addConstraints(hcDescriptionView)
        
        let hcString = "H:|-0-[contentView(scrollView)]-0-|"
        let vcString = "V:|-64-[contentView(scrollView)]-49-|"
        let hc = NSLayoutConstraint.constraintsWithVisualFormat(hcString,
                                                                options: NSLayoutFormatOptions.AlignAllBottom,
                                                                metrics: nil,
                                                                views: views)
        let vc = NSLayoutConstraint.constraintsWithVisualFormat(vcString,
                                                                options: NSLayoutFormatOptions.AlignAllLeft,
                                                                metrics: nil,
                                                                views: views)
        
        scrollView.addConstraints(hc)
        scrollView.addConstraints(vc)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension FullScreenViewController: UIScrollViewDelegate {
    
}
