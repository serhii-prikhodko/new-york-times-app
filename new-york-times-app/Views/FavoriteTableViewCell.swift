//
//  FavoriteTableViewCell.swift
//  new-york-times-app
//
//  Created by Serhiy Prikhodko on 4/7/20.
//  Copyright © 2020 Serhiy Prikhodko. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    //MARK: - Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var shortDescriptionLabel: UILabel!
    @IBOutlet weak var uiImageView: UIImageView!
    @IBOutlet weak var addToFavoriteButton: UIButton!
    weak var tabBarVC: TabBarController!
    var article: Article?
    var buttonHandler:(()-> Void)!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Functions
    @IBAction func favButtonClicked(_ sender: Any) {
        self.buttonHandler()
    }
    func update(with article: Article?) {
        self.uiImageView.image = UIImage(named: "no_image_placeholder")
        if let article = article {
            self.article = article
            self.titleLabel.text = article.title
            self.shortDescriptionLabel.text = article.abstract
            NetworkService.fetchArticleImage(article: article, completionHandler: {(data: Data?) in
                if let data = data {
                    DispatchQueue.main.async { [weak self] in
                        self?.uiImageView.image = UIImage(data: data)
                    }
                }
            })
        }
    }
    func changeFavoriteIconImage(isAdded: Bool) {
        let inFavoritesIcon = UIImage(named: "fav_icon_filled@2x")
        let notInFavoritesIcon = UIImage(named: "fav_icon_empty@2x")
        if isAdded {
            self.addToFavoriteButton.setImage(inFavoritesIcon, for: .normal)
        } else {
            self.addToFavoriteButton.setImage(notInFavoritesIcon, for: .normal)
        }
    }
}
