//
//  SearchModel.swift
//  MovieTiers
//
//  Created by Ersan Shimshek on 25.07.2023.
//

import Foundation

struct Response: Codable {
    var data: [SearchItem]?
    
}

struct SearchItem: Codable {
    let title: String?
    let year: Int?
    let imageLinkString: String?
    let qid: String?
    
    private enum CodingKeys: String, CodingKey {
        case title = "title"
        case year = "year"
        case imageLinkString = "image"
        case qid = "qid"
    }
}
