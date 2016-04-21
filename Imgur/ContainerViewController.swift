//
//  ContainerViewController.swift
//  Imgur
//
//  Created by Ravi Prakash on 20/04/16.
//  Copyright © 2016 Ravi Prakash. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    let GRID = "Grid"
    let LIST = "List"
    let STAGGRED = "Staggerd"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func loadView() {
        super.loadView()
        let tabBarController = UITabBarController()
        tabBarController.tabBar.barTintColor = UIColor.darkGrayColor()
        let gridViewController = GridViewController()
        let listViewController = ListViewController()
        let staggerdViewController = StaggerdViewController()
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
    }

    func addCustomNavigationBar() -> UIView {
        let navigationBar = UIView()
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
        return navigationBar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
