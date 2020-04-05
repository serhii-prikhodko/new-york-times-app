//
//  FavoriteListTableViewController.swift
//  new-york-times-app
//
//  Created by Serhiy Prikhodko on 4/2/20.
//  Copyright © 2020 Serhiy Prikhodko. All rights reserved.
//

import UIKit

class FavoriteListTableViewController: UITableViewController {
    
    //MARK: - Properties
    var articles = [Article]()
    weak var tabBarVC: TabBarController!
    
    //MARK: - Life circle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarVC = self.tabBarController as? TabBarController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title  = "Favorite articles"
        self.articles = self.tabBarVC.articles
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "mostSharedCellId", for: indexPath) as! MostSharedArticleTableViewCell
        cell.update(with: self.articles[indexPath.row])
        
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
