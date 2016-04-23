//
//  GridViewController.swift
//  Imgur
//
//  Created by Ravi Prakash on 19/04/16.
//  Copyright © 2016 Ravi Prakash. All rights reserved.
//

import UIKit

class GridViewController: UIViewController {

    var heightOfTabBar = CGFloat()
    private let cellWidth = 96
    private let reuseIdentifier = "ImgurCell"
    private var gridView : UICollectionView!
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.redColor()
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

        gridView.backgroundColor = UIColor.darkGrayColor()
        gridView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(gridView)
        let views = ["gridView" : gridView]
        let hcString = "H:|-0-[gridView]-0-|"
        let vcString = "V:|-64-[gridView]-0-|"
        let horizontalConstranint = NSLayoutConstraint.constraintsWithVisualFormat(hcString, options: NSLayoutFormatOptions.AlignAllLeft, metrics: nil, views: views)
        let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat(vcString, options: NSLayoutFormatOptions.AlignAllTop, metrics: nil, views: views)
        self.view.addConstraints(horizontalConstranint)
        self.view.addConstraints(verticalConstraints)
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
        return 20
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! GridCollectionViewCell
        cell.backgroundColor = UIColor.redColor()
        return cell
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellWidth)
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
}

