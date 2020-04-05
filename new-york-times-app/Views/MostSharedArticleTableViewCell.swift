//
//  MostSharedArticleTableViewCell.swift
//  new-york-times-app
//
//  Created by Serhiy Prikhodko on 4/2/20.
//  Copyright © 2020 Serhiy Prikhodko. All rights reserved.
//

import UIKit

class MostSharedArticleTableViewCell: UITableViewCell {

    //MARK: - Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var shortDescriptionLabel: UILabel!
    @IBOutlet weak var uiImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Functions
    @IBAction func favoritesButtonPressed(_ sender: Any) {
    }
    
    func update(with article: Article?) {
        self.uiImageView.image = UIImage(named: "no_image_placeholder")
        if let artcile = article {
            self.titleLabel.text = artcile.title
            self.shortDescriptionLabel.text = artcile.abstract
            NetworkService.fetchArticleImage(article: artcile, completionHandler: {(data: Data?) in
                if let data = data {
                    DispatchQueue.main.async { [weak self] in
                        self?.uiImageView.image = UIImage(data: data)
                    }
                }
            })
        }
    }

}
