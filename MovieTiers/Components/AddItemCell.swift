//
//  AddItemCell.swift
//  MovieTiers
//
//  Created by Ersan Shimshek on 08.08.2023.
//

import Foundation
import UIKit

final class AddItemCell: UICollectionViewCell {
    
    //MARK: Cell identifier
    public static let cellID = "itemCell"
    
    //MARK: Properties
    let addButton = UIButton()
    
    //MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: Setup
extension AddItemCell {
    func setup(){
        contentView.addSubview(addButton)
        addButton.setImage(UIImage(named: "addButton"), for: [])
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButton.heightAnchor.constraint(equalToConstant: 100),
            addButton.widthAnchor.constraint(equalToConstant: 100),
            addButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            addButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
