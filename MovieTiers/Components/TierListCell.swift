//
//  TierListCell.swift
//  MovieTiers
//
//  Created by Ersan Shimshek on 01.08.2023.
//

import Foundation
import UIKit

final class TierListCell: UICollectionViewCell {
    
    public static let cellID = "tierCell"
    let titleLabel = UILabel()
    var stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        //ContentView
        backgroundColor = UIColor("#260E2B")
        layer.cornerRadius = 22
        
        //Title Label
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 22, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 12),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
        
        //Stack View
        contentView.addSubview(stackView)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
        ])
    }
    
    func configColors(colors: [String]){
        
        colors.forEach { item in
            let v = UIView()
            v.layer.cornerRadius = 18
            v.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                v.widthAnchor.constraint(equalToConstant: 30),
                v.heightAnchor.constraint(equalToConstant: 30)
            ])
            v.backgroundColor = UIColor(item)
            stackView.addArrangedSubview(v)
            print(item)
        }
    }
}
