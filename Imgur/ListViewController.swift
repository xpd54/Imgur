//
//  ListViewController.swift
//  Imgur
//
//  Created by Ravi Prakash on 20/04/16.
//  Copyright © 2016 Ravi Prakash. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    var imageView : BigImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.greenColor()
//        imageView.frame.size.height = 100
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
        imageView = BigImageView(frame: self.view.frame, image: AssetsManager.getImage(Image.PlaceHolder), imageInformation: informationDict)
        let height = informationDict[DataType.Height.rawValue]! as String
        let width = informationDict[DataType.Width.rawValue]! as String
        let widthOFScreen = UIScreen.mainScreen().bounds.width
        let heightOfImageView = (Int(height)! * Int(widthOFScreen)) / Int(width)!
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(imageView)
        
        let descriptionView = DescriptionView(frame: self.view.frame, imageInformation: informationDict)
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(descriptionView)
        let views = ["scoreView" : testView,
                     "imageView" : imageView,
                     "descriptionView" : descriptionView]
        let hcStringFullScreen = "H:|-0-[scoreView(descriptionView)]-0-|"
        let vcStringFullScreen = "V:|-64-[scoreView(49)]-1-[imageView(\(heightOfImageView))]-1-[descriptionView]-0-|"
        let hcStringImageView = "H:|-0-[imageView(descriptionView)]-0-|"
        let horizontalConstraintImageView = NSLayoutConstraint.constraintsWithVisualFormat(hcStringImageView, options: NSLayoutFormatOptions.AlignAllBottom, metrics: nil, views: views)
        let horizontalConstraintScore = NSLayoutConstraint.constraintsWithVisualFormat(hcStringFullScreen, options: NSLayoutFormatOptions.AlignAllBottom, metrics: nil, views: views)
        let verticalConstraintScore = NSLayoutConstraint.constraintsWithVisualFormat(vcStringFullScreen, options:
            NSLayoutFormatOptions.AlignAllLeft, metrics: nil, views: views)
        self.view.addConstraints(horizontalConstraintScore)
        self.view.addConstraints(verticalConstraintScore)
        self.view.addConstraints(horizontalConstraintImageView)
    }

    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animateAlongsideTransition({ (UIViewControllerTransitionCoordinatorContext) in
            let orient = UIApplication.sharedApplication().statusBarOrientation
            switch orient {
            case .Portrait:
                print("Portrait")
            default:
                print("nothing")
            }
            }) { (UIViewControllerTransitionCoordinatorContext) in
                print("rotation complete")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
