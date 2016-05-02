//
//  ContainerViewController.swift
//  Imgur
//
//  Created by Ravi Prakash on 20/04/16.
//  Copyright © 2016 Ravi Prakash. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController, ImgurData, Configuration {
    let GRID = "Grid"
    let LIST = "List"
    let STAGGRED = "Staggerd"
    var containerNavigationController: UINavigationController!
    var gridViewController : GridViewController!
    var listViewController : ListViewController!
    var staggerdViewController : GridViewController!
    var appTabBarController : UITabBarController!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGrayColor()
        // Do any additional setup after loading the view.
    }

    override func loadView() {
        super.loadView()
        appTabBarController = UITabBarController()
        appTabBarController.tabBar.barTintColor = UIColor.darkGrayColor()

        gridViewController = GridViewController()
        gridViewController.isGridView = true
        listViewController = ListViewController()
        staggerdViewController = GridViewController()
        staggerdViewController.isGridView = false
        let controllers = [gridViewController, listViewController, staggerdViewController]
        appTabBarController.viewControllers = controllers
        let tabBarItems = appTabBarController.tabBar.items! as [UITabBarItem]
        let firstTabBarItem = tabBarItems[0] as UITabBarItem
        let secondTabBarItem = tabBarItems[1] as UITabBarItem
        let thirdTabBarItem = tabBarItems[2] as UITabBarItem
        firstTabBarItem.title = GRID
        secondTabBarItem.title = LIST
        thirdTabBarItem.title = STAGGRED
        firstTabBarItem.image = AssetsManager.getImage(Image.Grid)
        secondTabBarItem.image = AssetsManager.getImage(Image.List)
        thirdTabBarItem.image = AssetsManager.getImage(Image.Staggerd)
        containerNavigationController = UINavigationController(rootViewController: appTabBarController)
        self.view.addSubview(containerNavigationController.view)
        self.addChildViewController(containerNavigationController)
        containerNavigationController.didMoveToParentViewController(self)
        containerNavigationController.hidesBarsOnSwipe = true
        self.addCustomNavigationBar((self.containerNavigationController?.navigationBar)!)
        
        loadImgurData(0)
    }

    func addCustomNavigationBar(navigationBar : UINavigationBar) {
        ViewEffect.addShadowEffect(navigationBar, opacity: 1.0)
        navigationBar.barTintColor = UIColor.lightGrayColor()
        navigationBar.translucent = false
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        let devInfoButton = UIBarButtonItem(image: AssetsManager.getImage(Image.Info), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(showInformation))
        let configButton = UIBarButtonItem(image: AssetsManager.getImage(Image.Config), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(showConfig))
        appTabBarController.navigationItem.rightBarButtonItems = [devInfoButton, configButton]
    }

    func showInformation() {
        let appinfo = AppInfoViewController()
        self.containerNavigationController.pushViewController(appinfo, animated: true)
    }

    func showConfig() {
        let config = ConfigViewController()
        config.configDelegate = self
        self.containerNavigationController.pushViewController(config, animated: true)
    }

    // MARK: Protocol Methods
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

    func configurationSaved() {
        // remove old data
        DataInMemoryCache.sharedInstance.imgurData.removeAllObjects()
        loadImgurData(0)
    }
    
    func loadImgurData(page : Int) {
        let dataLoder = DataLoader()
        dataLoder.loadImgurData(0)
        dataLoder.dataDeligate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
