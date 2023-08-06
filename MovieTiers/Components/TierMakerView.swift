//
//  TierMakerView.swift
//  MovieTiers
//
//  Created by Ersan Shimshek on 01.08.2023.
//

import Foundation
import UIKit

final class TierMakerView: UIView {
    
    let colorButton = UIButton()
    let tierTitle = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TierMakerView {
    func setup(){
        
        self.addSubview(colorButton)
        colorButton.layer.cornerRadius = 10
        colorButton.backgroundColor = .white
        colorButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            colorButton.topAnchor.constraint(equalTo: self.topAnchor),
            colorButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            colorButton.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        self.addSubview(tierTitle)
        
        //Title Textfield
        tierTitle.backgroundColor = .white
        tierTitle.textColor = .black
        tierTitle.layer.cornerRadius = 10
        
        tierTitle.font = UIFont(name: "Arial-BoldMT", size: 30)
        tierTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tierTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tierTitle.topAnchor.constraint(equalTo: self.topAnchor),
            tierTitle.leadingAnchor.constraint(equalTo: colorButton.trailingAnchor, constant: 10)
        ])
    }
}
