//
//  ListViewController.swift
//  Imgur
//
//  Created by Ravi Prakash on 20/04/16.
//  Copyright © 2016 Ravi Prakash. All rights reserved.
//

import UIKit
import SDWebImage
protocol ListViewScroll {
    func listViewScrolledToEnd()
}
class ListViewController: UIViewController {
    var tableView : UITableView!
    var listViewDelegate : ListViewScroll!
    private let navigationTitle = "List"
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func loadView() {
        super.loadView()
        setupTableView()
    }
    
    func setupTableView() {
        if tableView == nil {
            tableView = UITableView()
        }
        tableView.backgroundColor = UIColor.lightGrayColor()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = UIColor.darkGrayColor()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        var views = [String: AnyObject]()
        views.updateValue(tableView, forKey: "tableView")
        views.updateValue(self.view, forKey: "self")
        let hcString = "H:|-0-[tableView]-0-|"
        let vcString = "V:|-0-[tableView]-49-|"
        let horizontalConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hcString, options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: views)
        let verticalConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vcString, options: NSLayoutFormatOptions.AlignAllCenterY, metrics: nil, views: views)
        self.view.addConstraints(horizontalConstraint)
        self.view.addConstraints(verticalConstraint)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.topViewController?.title = navigationTitle
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
// Table view Delegates
extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataInMemoryCache.sharedInstance.imgurData.count
    }
    //    MARK: TableViewDataSourceDelegates Methods

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 96.0
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = ListTableViewCell()
        cell.backgroundColor = UIColor.clearColor()
        cell.restorationIdentifier = "cellIdentifier"
        let cellData = DataInMemoryCache.sharedInstance.imgurData.objectAtIndex(indexPath.row) as! NSMutableDictionary
        let title = "Title :- \((cellData.objectForKey(DataType.Title.rawValue) as! String))"
        cell.titleLabel.text = title
        if let discription = cellData.objectForKey(DataType.Description.rawValue) as? String {
            cell.descriptionLable.text = "#Discription:- \(discription)"
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
                cell.cellImageView.image = downloadedImage
                cell.progressView.hidden = true
            } else {
                print(error.localizedDescription)
            }
        }
        
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cellData = DataInMemoryCache.sharedInstance.imgurData.objectAtIndex(indexPath.row) as! NSDictionary
        let fullScreenViewController = FullScreenViewController()
        fullScreenViewController.imageInformation = cellData
        self.navigationController?.pushViewController(fullScreenViewController, animated: true)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

extension ListViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if self.tableView.contentOffset.y >= (self.tableView.contentSize.height - self.tableView.bounds.size.height){
            listViewDelegate.listViewScrolledToEnd()
        }
    }
}
