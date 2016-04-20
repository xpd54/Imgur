//
//  ContainerViewController.swift
//  Imgur
//
//  Created by Ravi Prakash on 20/04/16.
//  Copyright © 2016 Ravi Prakash. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

    var containerNavigationController: UINavigationController!
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
        let controllers = [gridViewController, listViewController]
        tabBarController.viewControllers = controllers

        let tabBarItems = tabBarController.tabBar.items! as [UITabBarItem]
        let firstTabBarItem = tabBarItems[0] as UITabBarItem
        let secondTabBarItem = tabBarItems[1] as UITabBarItem
        firstTabBarItem.title = "Grid"
        secondTabBarItem.title = "List"
        containerNavigationController = UINavigationController(rootViewController: tabBarController)
        self.view.addSubview(containerNavigationController.view)
        self.addChildViewController(containerNavigationController)
        containerNavigationController.didMoveToParentViewController(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
