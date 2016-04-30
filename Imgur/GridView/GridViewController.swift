//
//  GridViewController.swift
//  Imgur
//
//  Created by Ravi Prakash on 19/04/16.
//  Copyright © 2016 Ravi Prakash. All rights reserved.
//

import UIKit
import SDWebImage
class GridViewController: UIViewController {
    var heightOfTabBar = CGFloat()
    var gridView : UICollectionView!
    var isGridView : Bool!
    private let cellWidth = 96
    private let reuseIdentifier = "ImgurCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func loadView() {
        super.loadView()
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSizeMake(100, 100)
        gridView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(gridView)
        gridView.delegate   = self
        gridView.dataSource = self

        gridView.registerClass(GridCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        gridView.backgroundColor = UIColor.lightGrayColor()
        gridView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(gridView)
        let views = ["gridView" : gridView]
        let hcString = "H:|-0-[gridView]-0-|"
        let vcString = "V:|-0-[gridView]-49-|"
        let horizontalConstranint = NSLayoutConstraint.constraintsWithVisualFormat(hcString, options: NSLayoutFormatOptions.AlignAllLeft, metrics: nil, views: views)
        let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat(vcString, options: NSLayoutFormatOptions.AlignAllTop, metrics: nil, views: views)
        self.view.addConstraints(horizontalConstranint)
        self.view.addConstraints(verticalConstraints)
    }

    private func getCellWidth() -> CGFloat {
        let widthOFScreen = UIScreen.mainScreen().bounds.width
        //UIEdgeinsets is 5 pix
        let width = (widthOFScreen - 20.0) / 2.0
        return width;
    }

    private func getCellHeight(imageHeight : CGFloat, imageWidth : CGFloat, cellWidth: CGFloat) -> CGFloat {
        let heightOfImageView = (imageHeight * cellWidth) / imageWidth
        return heightOfImageView
    }

    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animateAlongsideTransition({ (UIViewControllerTransitionCoordinatorContext) in
            if self.gridView != nil {
                self.gridView.reloadData()
            }
        }) { (UIViewControllerTransitionCoordinatorContext) in
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension GridViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataInMemoryCache.sharedInstance.imgurData.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! GridCollectionViewCell
        let cellData = DataInMemoryCache.sharedInstance.imgurData.objectAtIndex(indexPath.row) as! NSMutableDictionary
        if let discription = cellData.objectForKey(DataType.Description.rawValue) {
            cell.textLabel.text = discription as? String
        }
        let imagelink = cellData.objectForKey(DataType.ImageLink.rawValue) as! String
        let imageUrl = NSURL(string: imagelink)
        // SDWebImageManager downlaod and cache images internally using it to simplyfy the task
        let manager = SDWebImageManager.sharedManager()
        manager.downloadImageWithURL(imageUrl, options: SDWebImageOptions.ContinueInBackground, progress: { (receivedSize, expectedSize) in
            let progress = (Float(receivedSize) / Float(expectedSize));
            cell.progressView.progress = progress
        }) { (image, error, cacheType, finished, url) in
            if (error == nil) && finished {
                var downloadedImage = image
                if cellData.objectForKey(DataType.Image.rawValue) != nil {
                    downloadedImage = cellData.objectForKey(DataType.Image.rawValue) as? UIImage
                } else {
                    cellData.setObject(downloadedImage, forKey: DataType.Image.rawValue)
                    DataInMemoryCache.sharedInstance.imgurData.replaceObjectAtIndex(indexPath.row, withObject: cellData)
                }
                cell.imageView.image = downloadedImage
                cell.progressView.hidden = true
            } else {
                print(error.localizedDescription)
            }
        }
        return cell
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if (self.isGridView == true) {
            return CGSize(width: cellWidth, height: cellWidth)
        } else {
            let cellData  = DataInMemoryCache.sharedInstance.imgurData.objectAtIndex(indexPath.row) as! NSDictionary
            let imageHeight = cellData.objectForKey(DataType.Height.rawValue) as! CGFloat
            let imageWidth = cellData.objectForKey(DataType.Width.rawValue) as! CGFloat
            let width = getCellWidth()
            let height = getCellHeight(imageHeight, imageWidth: imageWidth, cellWidth: width)
            return CGSize(width: width, height: height)
        }
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cellData = DataInMemoryCache.sharedInstance.imgurData.objectAtIndex(indexPath.row) as! NSDictionary
        let fullScreenViewController = FullScreenViewController()
        fullScreenViewController.imageInformation = cellData
        let navController = UINavigationController(rootViewController: fullScreenViewController)
        self.presentViewController(navController, animated: true, completion: nil)
    }
}

