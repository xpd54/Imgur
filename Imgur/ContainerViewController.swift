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
        let gridBarItem = UITabBarItem(title: "Grid", image: nil, tag: 0)
        let listBarItem = UITabBarItem(title: "List", image: nil, tag: 1)
        tabBarController.tabBarItem = gridBarItem
        tabBarController.tabBarItem = listBarItem
        let gridViewController = GridViewController()
        let listViewController = ListViewController()
        let controllers = [gridViewController, listViewController]
        tabBarController.viewControllers = controllers
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
