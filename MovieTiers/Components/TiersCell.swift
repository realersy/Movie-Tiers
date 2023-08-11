//
//  TiersCell.swift
//  MovieTiers
//
//  Created by Ersan Shimshek on 07.08.2023.
//

import Foundation
import UIKit

protocol TiersCellDelegate: AnyObject{
    func presentPicker(index: Int)
}

final class TiersCell: UICollectionViewCell {
    
    
    //MARK: Properties
    public static let cellID = "theTiersCell"
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.minimumInteritemSpacing = 6
        layout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        return collection
    }()
    
    weak var tiersCellDelegate: TiersCellDelegate?
    
    var tier: Tier?
    var ip: IndexPath?
    var tierListIndex: IndexPath?
    
    let tierNameLabel = UILabel()
    
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
extension TiersCell {
    func setup(){
        
        layer.cornerRadius = 22
        //Tier Name Label
        tierNameLabel.textColor = .white
        tierNameLabel.font = .systemFont(ofSize: 22, weight: .bold)
        tierNameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(tierNameLabel)
        NSLayoutConstraint.activate([
            tierNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            tierNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            tierNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 100),
            tierNameLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
        
        //CollectionView
        contentView.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SearchMovieCell.self, forCellWithReuseIdentifier: SearchMovieCell.cellID)
        collectionView.register(AddItemCell.self, forCellWithReuseIdentifier: AddItemCell.cellID)

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: tierNameLabel.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
    }
}
//MARK: Collection View Delegates and Data Source
extension TiersCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == tier!.items.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddItemCell.cellID, for: indexPath) as! AddItemCell
            cell.backgroundColor = .clear
            cell.addButton.addTarget(self, action: #selector(buttonPressed), for: .touchDown)
            cell.addButton.tag = (ip?.row)!
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchMovieCell.cellID, for: indexPath) as! SearchMovieCell
            cell.imageView.image = UIImage(data: (tier!.items[indexPath.row].imageData))
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row != tier?.items.count{
            ProfileService.shared.deleteTierItem(tierListIndex: (tierListIndex?.row)!, tierIndex: (ip?.row)!, deleteIndex: indexPath.row)
            tier = ProfileService.shared.getTierList(index: tierListIndex!.row).tierList[ip!.row]
            collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tier!.items.count+1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width / 3) - 24
        return CGSize(width: width, height: width*1.6)
    }
}

//MARK: Selector functions
extension TiersCell {
    @objc func buttonPressed(sender: UIButton){
        tiersCellDelegate?.presentPicker(index: sender.tag)
    }
}
