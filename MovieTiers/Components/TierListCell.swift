//
//  TierListCell.swift
//  MovieTiers
//
//  Created by Ersan Shimshek on 01.08.2023.
//

import Foundation
import UIKit

final class TierListCell: UICollectionViewCell {
    //MARK: Cell identifier
    public static let cellID = "tierCell"
    
    //MARK: Properties
    let titleLabel = UILabel()
    let closeButton = UIButton()
    var stackView = UIStackView()
    
    //MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        stackView.arrangedSubviews.map{
            $0.removeFromSuperview()
        }
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
        }
    }
}

//MARK: Setup
extension TierListCell {
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
        
        //Close Button
        closeButton.setImage(UIImage(named: "close"), for: [])
        contentView.addSubview(closeButton)
        closeButton.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            closeButton.heightAnchor.constraint(equalToConstant: 35),
            closeButton.widthAnchor.constraint(equalToConstant: 35),
            closeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -9),
            closeButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 9)
        ])
    }
}
//MARK: Selector Functions
extension TierListCell {
    @objc func closeButtonPressed(sender: UIButton){
        ProfileService.shared.deleteTierList(index: sender.tag)
    }
}
