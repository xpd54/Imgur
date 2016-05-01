//
//  AppInfoViewController.swift
//  Imgur
//
//  Created by Ravi Prakash on 01/05/16.
//  Copyright © 2016 Ravi Prakash. All rights reserved.
//

import UIKit

class AppInfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationItem.title = "App Info"
        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        super.loadView()
        let version = UILabel()
        version.translatesAutoresizingMaskIntoConstraints = false
        version.font = UIFont.boldSystemFontOfSize(18.0)
        version.backgroundColor = UIColor.lightGrayColor()
        if let v = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString") as? String {
            version.text = "Version Number :- v\(v)"
        }
        let build = UILabel()
        build.translatesAutoresizingMaskIntoConstraints = false
        build.font = UIFont.boldSystemFontOfSize(18.0)
        build.backgroundColor = UIColor.lightGrayColor()
        if let b = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleVersion") as? String {
            build.text = "Build Number :- \(b)"
        }
        let time = UILabel()
        time.text = "Time :- \(NSDate())"
        time.font = UIFont.boldSystemFontOfSize(18)
        time.translatesAutoresizingMaskIntoConstraints = false
        time.backgroundColor = UIColor.lightGrayColor()
        let authorName = UILabel()
        authorName.translatesAutoresizingMaskIntoConstraints = false
        authorName.numberOfLines = 0
        authorName.backgroundColor = UIColor.lightGrayColor()
        authorName.text = "Name :- Ravi Prakash \nEmail :- raviprakash.xpd54@gmail.com"
        authorName.font = UIFont.boldSystemFontOfSize(14)
        self.view.addSubview(version)
        self.view.addSubview(build)
        self.view.addSubview(time)
        self.view.addSubview(authorName)
        let views = ["version" : version,
                     "build" : build,
                     "time" : time,
                     "authorName" : authorName,
                     ]
        let hcStringVersion = "H:|-0-[version(==build)]-0-|"
        let hcStringTime = "H:|-0-[time]-0-|"
        let hcStringAuthorName = "H:|-0-[authorName]-0-|"
        let vcStringAuthorName = "V:|-0-[version(30)]-2-[build(30)]-2-[time(30)]-2-[authorName(60)]"
        let hcVersion = NSLayoutConstraint.constraintsWithVisualFormat(hcStringVersion,
                                                                       options: NSLayoutFormatOptions.AlignAllTop,
                                                                       metrics: nil,
                                                                       views: views)
        let hcTime = NSLayoutConstraint.constraintsWithVisualFormat(hcStringTime,
                                                                    options: NSLayoutFormatOptions.AlignAllTop,
                                                                    metrics: nil,
                                                                    views: views)
        let hcAuthorName = NSLayoutConstraint.constraintsWithVisualFormat(hcStringAuthorName,
                                                                          options: NSLayoutFormatOptions.AlignAllTop,
                                                                          metrics: nil,
                                                                          views: views)
        let vcAuthorName = NSLayoutConstraint.constraintsWithVisualFormat(vcStringAuthorName,
                                                                         options: NSLayoutFormatOptions.AlignAllLeft,
                                                                         metrics: nil,
                                                                         views: views)
        self.view.addConstraints(hcVersion)
        self.view.addConstraints(hcTime)
        self.view.addConstraints(hcAuthorName)
        self.view.addConstraints(vcAuthorName)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
