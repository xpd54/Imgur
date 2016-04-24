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
    private let cellWidth = 96
    private let reuseIdentifier = "ImgurCell"
    private var gridView : UICollectionView!
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
        let vcString = "V:|-64-[gridView]-0-|"
        let horizontalConstranint = NSLayoutConstraint.constraintsWithVisualFormat(hcString, options: NSLayoutFormatOptions.AlignAllLeft, metrics: nil, views: views)
        let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat(vcString, options: NSLayoutFormatOptions.AlignAllTop, metrics: nil, views: views)
        self.view.addConstraints(horizontalConstranint)
        self.view.addConstraints(verticalConstraints)
        self.loadImgurData(1)
    }

    func loadImgurData(pageNo:Int) {
        let endPoint = "hot/viral/\(pageNo).json"
        CoreApi.makeApiCallForUrlEndPoint(endPoint, method: NetworkMethod.GET, apiData: nil) { (response) in
            let imgurDataList = DataManager.getListOfData(response)
            DataInMemoryCache.sharedInstance.imgurData.addObjectsFromArray(imgurDataList as [AnyObject])
            self.gridView.reloadData()
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
        let cellData = DataInMemoryCache.sharedInstance.imgurData.objectAtIndex(indexPath.row) as! NSDictionary
        if let discription = cellData.objectForKey(DataType.Description.rawValue) {
            cell.textLabel.text = discription as? String
        }
        let imagelink = cellData.objectForKey(DataType.ImageLink.rawValue) as! String
        let imageUrl = NSURL(string: imagelink)

        let manager = SDWebImageManager.sharedManager()
        manager.downloadImageWithURL(imageUrl, options: SDWebImageOptions.ContinueInBackground, progress: { (receivedSize, expectedSize) in
            let progress = (Float(receivedSize) / Float(expectedSize));
            cell.progressView.progress = progress
        }) { (image, error, cacheType, finished, url) in
            if (error == nil) && finished {
                print(image)
                cell.imageView.image = image
                cell.progressView.hidden = true
            } else {
                print(error.localizedDescription)
            }
        }
        return cell
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellWidth)
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
}

