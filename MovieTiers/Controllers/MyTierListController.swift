//
//  MyTierListController.swift
//  MovieTiers
//
//  Created by Ersan Shimshek on 25.07.2023.
//

import Foundation
import UIKit

final class MyTierListController: UIViewController {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.minimumInteritemSpacing = 6
        layout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        return collection
    }()
    let tiers = [Tier(colorHex: "#ABC123", name: "Shit", items: []),
                 Tier(colorHex: "#123ABC", name: "Nice", items: []), Tier(colorHex: "#42AB43", name: "Garbage", items: [])
                ]
    var tierLists = [TierList]() 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tierLists = [TierList(tierList: tiers, title: "dramas")]
        collectionView.backgroundColor = UIColor("#33377A")
        setup()
    }
}

extension MyTierListController {
    func setup(){
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(AddTierCell.self, forCellWithReuseIdentifier: AddTierCell.cellID)
        collectionView.register(TierListCell.self, forCellWithReuseIdentifier: TierListCell.cellID)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
    }
}

extension MyTierListController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tierLists.count+1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == tierLists.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddTierCell.cellID, for: indexPath) as! AddTierCell
            cell.addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TierListCell.cellID, for: indexPath) as! TierListCell
            cell.titleLabel.text = tierLists[indexPath.row].title
            cell.configColors(colors: tierLists[indexPath.row].getColorsArray())
            return cell
        }

    }
    
    @objc func addButtonPressed(){
        let makeNewTierController = MakeNewTierListController()
        makeNewTierController.delegate = self
        navigationController?.pushViewController(makeNewTierController, animated: true)
    }
}

extension MyTierListController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.width-24, height: 120)
            
    }
}

extension MyTierListController: TierListDelegate {
    func tierListDidChange(newTierList: TierList) {
        tierLists.append(newTierList)
        collectionView.reloadData()
    }
}
