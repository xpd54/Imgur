//
//  ListViewController.swift
//  Imgur
//
//  Created by Ravi Prakash on 20/04/16.
//  Copyright © 2016 Ravi Prakash. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.greenColor()
        // Do any additional setup after loading the view.
    }

    override func loadView() {
        super.loadView()
        let informationDict = [DataType.Title.rawValue : "Title",
                               DataType.Description.rawValue : "Description a quick dog jums ober the lazy dog ye he did so what you wanna do do exactly that's ok",
                               DataType.UpVote.rawValue: "10",
                               DataType.DownVote.rawValue: "20",
                               DataType.Score.rawValue: "12",
                               DataType.Height.rawValue: "150",
                               DataType.Width.rawValue: "150"]
        let testView = ScoreView(frame: self.view.frame, imageInformation: informationDict)
        testView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(testView)
        let imageView = BigImageView(frame: self.view.frame, image: AssetsManager.getImage(Image.PlaceHolder), imageInformation: informationDict)
        let height = informationDict[DataType.Height.rawValue]! as String
        let width = informationDict[DataType.Width.rawValue]! as String
        let widthOFScreen = UIScreen.mainScreen().bounds.width
        let heightOfImageView = (Int(height)! * Int(widthOFScreen)) / Int(width)!
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(imageView)
        let views = ["scoreView" : testView,
                     "imageView" : imageView]
        let hcStringFullScreen = "H:|-0-[scoreView]-0-|"
        let vcStringFullScreen = "V:|-64-[scoreView(49)]-1-[imageView(\(heightOfImageView))]"
        let hcStringImageView = "H:|-1-[imageView]-1-|"
        let horizontalConstraintImageView = NSLayoutConstraint.constraintsWithVisualFormat(hcStringImageView, options: NSLayoutFormatOptions.AlignAllBottom, metrics: nil, views: views)
        let horizontalConstraintScore = NSLayoutConstraint.constraintsWithVisualFormat(hcStringFullScreen, options: NSLayoutFormatOptions.AlignAllBottom, metrics: nil, views: views)
        let verticalConstraintScore = NSLayoutConstraint.constraintsWithVisualFormat(vcStringFullScreen, options:
            NSLayoutFormatOptions.AlignAllLeft, metrics: nil, views: views)
        self.view.addConstraints(horizontalConstraintScore)
        self.view.addConstraints(verticalConstraintScore)
        self.view.addConstraints(horizontalConstraintImageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
