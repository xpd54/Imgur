//
//  ContainerViewController.swift
//  Imgur
//
//  Created by Ravi Prakash on 20/04/16.
//  Copyright © 2016 Ravi Prakash. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController, ImgurData {
    let GRID = "Grid"
    let LIST = "List"
    let STAGGRED = "Staggerd"
    var gridViewController : GridViewController!
    var listViewController : ListViewController!
    var staggerdViewController : GridViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func loadView() {
        super.loadView()
        let tabBarController = UITabBarController()
        tabBarController.tabBar.barTintColor = UIColor.darkGrayColor()
        gridViewController = GridViewController()
        gridViewController.isGridView = true
        listViewController = ListViewController()
        staggerdViewController = GridViewController()
        staggerdViewController.isGridView = false
        let controllers = [gridViewController, listViewController, staggerdViewController]
        tabBarController.viewControllers = controllers

        let tabBarItems = tabBarController.tabBar.items! as [UITabBarItem]
        let firstTabBarItem = tabBarItems[0] as UITabBarItem
        let secondTabBarItem = tabBarItems[1] as UITabBarItem
        let thirdTabBarItem = tabBarItems[2] as UITabBarItem
        firstTabBarItem.title = GRID
        secondTabBarItem.title = LIST
        thirdTabBarItem.title = STAGGRED
        firstTabBarItem.image = AssetsManager.getImage(Image.Grid)
        secondTabBarItem.image = AssetsManager.getImage(Image.List)
        thirdTabBarItem.image = AssetsManager.getImage(Image.Staggerd)
        self.view.addSubview(tabBarController.view)
        self.addChildViewController(tabBarController)
        tabBarController.didMoveToParentViewController(self)
        self.addCustomNavigationBar()
        let dataLoder = DataLoader()
        dataLoder.loadImgurData(0)
        dataLoder.dataDeligate = self
    }

    func addCustomNavigationBar() -> UINavigationBar {
        let navigationBar = UINavigationBar()
        navigationBar.backgroundColor = UIColor.lightGrayColor()
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(navigationBar)
        let views = ["navigationBar" : navigationBar]
        let hcString = "H:|-0-[navigationBar]-0-|"
        let vcString = "V:|-0-[navigationBar(64)]"
        let horizontalConstraint = NSLayoutConstraint.constraintsWithVisualFormat(hcString, options:NSLayoutFormatOptions.AlignAllLeft, metrics: nil, views: views)
        let verticalConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vcString, options: NSLayoutFormatOptions.AlignAllTop, metrics: nil, views: views)
        self.view.addConstraints(horizontalConstraint)
        self.view.addConstraints(verticalConstraint)
        ViewEffect.addShadowEffect(navigationBar, opacity: 1.0)
        return navigationBar
    }
    
    func imgurDataGotLoaded() {
        if gridViewController.gridView != nil {
            gridViewController.gridView.reloadData()
        }

        if listViewController.tableView != nil {
            listViewController.tableView.reloadData()
        }

        if staggerdViewController.gridView != nil {
            staggerdViewController.gridView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
