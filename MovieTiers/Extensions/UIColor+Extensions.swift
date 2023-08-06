//
//  UIColor+Extensions.swift
//  MovieTiers
//
//  Created by Ersan Shimshek on 25.07.2023.
//

import Foundation
import UIKit

extension UIColor {
    convenience init?(_ hex: String) {
        if hex.hasPrefix("#") {
            let hexString = String(hex.dropFirst(1))
            if hexString.count == 6 {
                let scanner = Scanner(string: hexString)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    let r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                    let g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                    let b = CGFloat((hexNumber & 0x0000ff)) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: 1)
                    return
                }
            }
        }
        return nil
    }
}

extension UIColor {
        func toHexString() -> String {
            var r:CGFloat = 0
            var g:CGFloat = 0
            var b:CGFloat = 0
            var a:CGFloat = 0

            getRed(&r, green: &g, blue: &b, alpha: &a)

            let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0

            return String(format:"#%06x", rgb)
        }
    }
