//
//  Media.swift
//  new-york-times-app
//
//  Created by Serhiy Prikhodko on 3/31/20.
//  Copyright © 2020 Serhiy Prikhodko. All rights reserved.
//

import Foundation

struct Media: Codable {
    var mediaMetadata: [MediaMetadata]?
    
    private enum CodingKeys : String, CodingKey {
        case mediaMetadata = "media-metadata"
    }
}
struct MediaMetadata: Codable {
    var url: String?
}
