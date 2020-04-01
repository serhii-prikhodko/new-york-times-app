//
//  Article.swift
//  new-york-times-app
//
//  Created by Serhiy Prikhodko on 3/30/20.
//  Copyright © 2020 Serhiy Prikhodko. All rights reserved.
//

import Foundation

struct Article: Codable {
    var title: String?
    var url: String?
    var abstract: String?
    var media: [Media]?
}

struct ArticleList: Codable {
    var results: [Article]
}
