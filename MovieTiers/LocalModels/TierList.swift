//
//  TierList.swift
//  MovieTiers
//
//  Created by Ersan Shimshek on 25.07.2023.
//

import Foundation

struct TierList: Codable {
    //MARK: Parameters
    var tierList: [Tier]
    var title: String
    
    //Returns an array of colors in hex
    func getColorsArray() -> [String] {
        var arr: [String] = []
        tierList.forEach { item in
            arr.append(item.colorHex)
        }
        return arr
    }
}
