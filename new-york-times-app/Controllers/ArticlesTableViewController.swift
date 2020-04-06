//
//  MostViewedTableViewController.swift
//  new-york-times-app
//
//  Created by Serhiy Prikhodko on 3/31/20.
//  Copyright © 2020 Serhiy Prikhodko. All rights reserved.
//

import UIKit

class ArticlesTableViewController: UITableViewController {
    
    //MARK: - Properties
    var articles = [Article]()
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    var mostPopularParam = MostPopularParam.viewed
    
    //MARK: - Life circle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshControl?.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.articles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCellId", for: indexPath) as! ArticleTableViewCell
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
    @objc func refresh(sender:AnyObject) {
        self.loadArticles(mostPopularParam: self.mostPopularParam)

        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }
    
    func prepareActivityIndicator() {
        self.activityIndicatorView.hidesWhenStopped = true
        self.activityIndicatorView.startAnimating()
    }
    
    func loadArticles(mostPopularParam: MostPopularParam) {
        self.prepareActivityIndicator()
        NetworkService.fetchArticles(mostPopularParam: mostPopularParam) { (articles: ArticleList?, error: Error?) in
            if let articles = articles {
                DispatchQueue.main.async {
                    self.articles = articles.results
                    self.activityIndicatorView?.stopAnimating()
                    self.tableView.reloadData()
                }
            } else {
                DispatchQueue.main.async {
                    self.showAlert(title: "Warning", message: error?.localizedDescription ?? "Something went wrong, try again later", style: .alert)
                }
            }
        }
    }
    func showAlert (title: String, message: String, style: UIAlertController.Style){
        let alertController = UIAlertController (title: title, message: message, preferredStyle: style)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
}
