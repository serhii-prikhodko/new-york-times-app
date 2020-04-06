//
//  TabBarController.swift
//  new-york-times-app
//
//  Created by Serhiy Prikhodko on 4/3/20.
//  Copyright © 2020 Serhiy Prikhodko. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    //MARK: - Properties
    var mostViewedVC = ArticlesTableViewController()
    var mostSharedVC = ArticlesTableViewController()
    var mostEmailedVC = ArticlesTableViewController()
    
    //MARK: - Life circle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareTabBarItems()
        self.loadVCData()
        self.delegate = self
    }
    
    //MARK: - Functions
    func prepareTabBarItems() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        self.mostViewedVC = storyBoard.instantiateViewController(withIdentifier: "articleController") as! ArticlesTableViewController
        self.mostSharedVC = storyBoard.instantiateViewController(withIdentifier: "articleController") as! ArticlesTableViewController
        self.mostEmailedVC = storyBoard.instantiateViewController(withIdentifier: "articleController") as! ArticlesTableViewController
        
        self.mostViewedVC.tabBarItem = UITabBarItem(title: "Most Viewed", image: UIImage(named: "most_viewed_tab_icon@3x"), tag: 0)
        self.mostViewedVC.title = self.mostViewedVC.tabBarItem.title
        self.mostSharedVC.tabBarItem = UITabBarItem(title: "Most Shared", image: UIImage(named: "most_shared_tab_icon@3x"), tag: 1)
        self.mostEmailedVC.tabBarItem = UITabBarItem(title: "Most Emailed", image: UIImage(named: "most_emailed_tab_icon@3x"), tag: 2)
        
        
        let viewControllerList = [self.mostViewedVC, self.mostSharedVC, self.mostEmailedVC]
        viewControllers = viewControllerList
    }
    func loadVCData() {
        self.mostViewedVC.loadArticles(mostPopularParam: MostPopularParam.viewed)
    }
    //MARK: - Delegate methods
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        switch viewController {
        case self.mostSharedVC:
            self.mostSharedVC.mostPopularParam = MostPopularParam.shared
            self.mostSharedVC.loadArticles(mostPopularParam: MostPopularParam.shared)
        case self.mostEmailedVC:
            self.mostEmailedVC.mostPopularParam = MostPopularParam.emailed
            self.mostEmailedVC.loadArticles(mostPopularParam: MostPopularParam.emailed)
        default:
            return
        }
    }
}
