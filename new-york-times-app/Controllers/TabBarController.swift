//
//  TabBarController.swift
//  new-york-times-app
//
//  Created by Serhiy Prikhodko on 4/3/20.
//  Copyright © 2020 Serhiy Prikhodko. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    //MARK: - Properties
    var articles = [Article]()
    let mostViewedVC = ArticleTableViewCell()
    let mostSharedVC = ArticleTableViewCell()
    let favoritesVC = ArticleTableViewCell()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
