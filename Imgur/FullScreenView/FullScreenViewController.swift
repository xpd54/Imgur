//
//  FullScreenViewController.swift
//  Imgur
//
//  Created by Ravi Prakash on 26/04/16.
//  Copyright © 2016 Ravi Prakash. All rights reserved.
//

import UIKit
import SDWebImage
class FullScreenViewController: UIViewController {
    var imageInformation : NSDictionary!
    private var imageHeight : CGFloat!
    private var imageWidth : CGFloat!
    private let heightOfScoreView : CGFloat = 49.0
    private var imageViewHC : [NSLayoutConstraint]!
    private var contentViewHC : [NSLayoutConstraint]!
    private var descriptionView : UITextView!
    private var navController = UINavigationController()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar((self.navigationController?.navigationBar)!)
        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        super.loadView()
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor.darkGrayColor()
        self.view.addSubview(scrollView)
        
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        let height = imageInformation.objectForKey(DataType.Height.rawValue) as! Int
        let width = imageInformation.objectForKey(DataType.Width.rawValue) as! Int
        self.imageWidth = CGFloat(width)
        self.imageHeight = CGFloat(height)
        // Add ScoreView
        let scoreView = ScoreView(frame: self.view.frame, imageInformation: imageInformation)
        scoreView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(scoreView)

        let link = imageInformation.objectForKey(DataType.ImageLink.rawValue) as! String
        let imageUrl = NSURL(string: link)
        // Add ProgressBar and ImageView
        let imageView = UIImageView(image: AssetsManager.getImage(Image.PlaceHolder))
        let progressBar = UIProgressView()
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        progressBar.progressTintColor = UIColor.greenColor()
        imageView.addSubview(progressBar)
        // Download image or set if it's stored in cache
        if let image = imageInformation.objectForKey(DataType.Image.rawValue) as? UIImage {
            imageView.image = image
            progressBar.hidden = true
        } else {
            let manager = SDWebImageManager.sharedManager()
            manager.downloadImageWithURL(imageUrl, options: SDWebImageOptions.ContinueInBackground, progress: { (receivedSize, expectedSize) in
                let progress = (Float(receivedSize) / Float(expectedSize));
                progressBar.progress = progress
            }) { (image, error, cacheType, finished, url) in
                if (error == nil) && finished {
                    imageView.image = image
                    progressBar.hidden = true
                } else {
                    print(error.localizedDescription)
                }
            }
        }
        imageView.contentMode = .ScaleAspectFit
        imageView.backgroundColor = UIColor.blackColor()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        // Add image descriptionView
        descriptionView = UITextView()
        if let des = imageInformation.objectForKey(DataType.Description.rawValue) as? String {
                descriptionView.text = des
        }
        descriptionView.textAlignment = .Left
        descriptionView.editable = false
        descriptionView.selectable = false
        descriptionView.sizeToFit()
        descriptionView.font = UIFont.systemFontOfSize(14)
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        descriptionView.backgroundColor = UIColor.darkGrayColor()
        contentView.addSubview(descriptionView)
        let views = ["contentView" : contentView,
                     "scoreView" : scoreView,
                     "scrollView" : scrollView,
                     "imageView" : imageView,
                     "descriptionView" : descriptionView,
                     "progressBar" : progressBar]
        // ProgressBar constraints
        let hcStringProgressBar = "H:|-0-[progressBar]-0-|"
        let vcStringProgressBar = "V:|-0-[progressBar]"
        let hcProgressBar = NSLayoutConstraint.constraintsWithVisualFormat(hcStringProgressBar,
                                                                           options: NSLayoutFormatOptions.AlignAllTop,
                                                                           metrics: nil,
                                                                           views: views)
        let vcProgressBar = NSLayoutConstraint.constraintsWithVisualFormat(vcStringProgressBar,
                                                                           options: NSLayoutFormatOptions.AlignAllLeft,
                                                                           metrics: nil,
                                                                           views: views)
        imageView.addConstraints(hcProgressBar)
        imageView.addConstraints(vcProgressBar)

        // ScrollView constraints
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
        // ScoreView Constraint
        let hcStringScoreView = "H:|-0-[scoreView(imageView)]-0-|"
        let vcStringScoreView = "V:|-0-[scoreView(\(heightOfScoreView))]-[imageView]"
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
        // Image View constraint
        let heightOfImageView = getHeightOfImageView()
        let vcStringImageView = "V:[imageView(\(heightOfImageView))]"
        imageViewHC = NSLayoutConstraint.constraintsWithVisualFormat(vcStringImageView, options: NSLayoutFormatOptions.AlignAllLeft, metrics: nil, views: views)
        imageView.addConstraints(imageViewHC)
        // Description View constraint
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
        contentView.addConstraints(vcDescriptionView)
        contentView.addConstraints(hcDescriptionView)
        // Scroll view content View constraint
        let hcString = "H:|-0-[contentView(scrollView)]-0-|"
        let vcString = "V:|-0-[contentView]-0-|"
        let hcStringContentView = "V:[contentView(\(heightOfImageView + heightOfScoreView + self.getHeightOfTextView(descriptionView)))]"
        let hc = NSLayoutConstraint.constraintsWithVisualFormat(hcString,
                                                                options: NSLayoutFormatOptions.AlignAllBottom,
                                                                metrics: nil,
                                                                views: views)
        let vc = NSLayoutConstraint.constraintsWithVisualFormat(vcString,
                                                                options: NSLayoutFormatOptions.AlignAllLeft,
                                                                metrics: nil,
                                                                views: views)
        contentViewHC = NSLayoutConstraint.constraintsWithVisualFormat(hcStringContentView,
                                                                              options: NSLayoutFormatOptions.AlignAllLeft,
                                                                              metrics: nil,
                                                                              views: views)
        contentView.addConstraints(contentViewHC)
        scrollView.addConstraints(hc)
        scrollView.addConstraints(vc)
    }
    
    private func getHeightOfImageView() -> CGFloat {
        let widthOFScreen = UIScreen.mainScreen().bounds.width
        let heightOfImageView = (self.imageHeight * widthOFScreen) / self.imageWidth
        return heightOfImageView
    }
    // handle orientation
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animateAlongsideTransition({ (UIViewControllerTransitionCoordinatorContext) in
            let orient = UIApplication.sharedApplication().statusBarOrientation
            switch orient {
            default:
                if (self.imageInformation != nil) {
                    self.recalculateConstraints()
                }
            }
        }) { (UIViewControllerTransitionCoordinatorContext) in
            if (self.imageInformation != nil) {
                UIView.animateWithDuration(0.5, animations: {
                    self.view.layoutIfNeeded()
                })
            }
        }
    }

    private func recalculateConstraints() {
        for constraint in self.imageViewHC {
            if constraint.firstAttribute == NSLayoutAttribute.Height && constraint.secondAttribute == NSLayoutAttribute.NotAnAttribute{
                constraint.constant = self.getHeightOfImageView()
            }
        }

        for constraint in self.contentViewHC {
            if constraint.firstAttribute == NSLayoutAttribute.Height && constraint.secondAttribute == NSLayoutAttribute.NotAnAttribute{
                constraint.constant = getHeightOfTextView(descriptionView) + self.heightOfScoreView + self.getHeightOfImageView()
            }
        }
    }

    private func getHeightOfTextView(textView : UITextView) -> CGFloat {
        let size = textView.sizeThatFits(CGSizeMake(UIScreen.mainScreen().bounds.width, CGFloat(FLT_MAX)))
        return size.height
    }

    private func setupNavigationBar(navigationBar: UINavigationBar) {
        ViewEffect.addShadowEffect(navigationBar, opacity: 1.0)
        navigationBar.translucent = false
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        let closeButtonTitle = "Close"
        let closeButton = UIBarButtonItem(title: closeButtonTitle, style: UIBarButtonItemStyle.Plain, target: self, action: #selector(self.closeView))
        self.navigationItem.leftBarButtonItem = closeButton
        self.navigationItem.title = "Image"
    }
    
    func closeView() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension FullScreenViewController: UIScrollViewDelegate {
    
}
