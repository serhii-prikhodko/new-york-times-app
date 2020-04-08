//
//  FavoritesTableViewController.swift
//  new-york-times-app
//
//  Created by Serhiy Prikhodko on 4/7/20.
//  Copyright © 2020 Serhiy Prikhodko. All rights reserved.
//

import UIKit

class FavoritesTableViewController: UITableViewController {
    //MARK: - Properties
    var articles = [Article]()
    var mostPopularParam = MostPopularParam.viewed
    weak var tabBarVC: TabBarController!
    
    //MARK: - Life circle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarVC = self.tabBarController as? TabBarController
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.articles = self.tabBarVC.favoriteArticles
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCellId", for: indexPath) as! FavoriteTableViewCell
        cell.update(with: self.articles[indexPath.row])
        // Add selected article to favorites
        cell.buttonHandler = {()-> Void in
            if let article = cell.article {
                self.tabBarVC.favoriteArticles.append(article)
                cell.changeFavoriteIconImage(isAdded: true)
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "webPageId") as! WebPageViewController
        //Transfer data to next view controller
        newViewController.url = (self.articles[indexPath.row].url)
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    // MARK: - Functions
    func showAlert (title: String, message: String, style: UIAlertController.Style){
        let alertController = UIAlertController (title: title, message: message, preferredStyle: style)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
}
