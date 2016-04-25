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
        let testView = FullScreenView(frame: self.view.frame, image: AssetsManager.getImage(Image.PlaceHolder), imageInformation: informationDict)
        testView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(testView)
        let views = ["scoreView" : testView]
        let hcStringFullScreen = "H:|-0-[scoreView]-0-|"
        let vcStringFullScreen = "V:|-64-[scoreView]-100-|"
        let horizontalConstraintScore = NSLayoutConstraint.constraintsWithVisualFormat(hcStringFullScreen, options: NSLayoutFormatOptions.AlignAllBottom, metrics: nil, views: views)
        let verticalConstraintScore = NSLayoutConstraint.constraintsWithVisualFormat(vcStringFullScreen, options:
            NSLayoutFormatOptions.AlignAllLeft, metrics: nil, views: views)
        self.view.addConstraints(horizontalConstraintScore)
        self.view.addConstraints(verticalConstraintScore)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
