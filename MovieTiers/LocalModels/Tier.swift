//
//  Category.swift
//  MovieTiers
//
//  Created by Ersan Shimshek on 25.07.2023.
//

import Foundation

struct Tier: Codable {
    //MARK: Parameters
    var colorHex: String
    var name: String
    var items: [Item]
    
}
