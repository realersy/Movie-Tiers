//
//  TierList.swift
//  MovieTiers
//
//  Created by Ersan Shimshek on 25.07.2023.
//

import Foundation

struct TierList {
    let tierList: [Tier]
    let title: String
    
    func getColorsArray() -> [String] {
        var arr: [String] = []
        tierList.forEach { item in
            arr.append(item.colorHex)
        }
        return arr
    }
}
