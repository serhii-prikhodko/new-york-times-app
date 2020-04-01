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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadArticles()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    // MARK: - Functions
    func loadArticles() {
        NetworkService.fetchArticles() { (articles: ArticleList?, error: Error?) in
            if let articles = articles {
                DispatchQueue.main.async {
                    self.articles = articles.results
                    //self.activityIndicatorView.stopAnimating()
                    self.tableView.reloadData()
                    print(self.articles)
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
