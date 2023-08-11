//
//  MyTierListController.swift
//  MovieTiers
//
//  Created by Ersan Shimshek on 25.07.2023.
//

import Foundation
import UIKit

final class MyTierListController: UIViewController {
    
    //MARK: Parameters
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.minimumInteritemSpacing = 6
        layout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        return collection
    }()
    var tierLists = [TierList]()
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor("#33377A")
        setup()
    }
}

//MARK: Setup
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
//MARK: CollectionView Delegate/Data Source, UICollectionViewDelgateFlowLayout
extension MyTierListController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
            cell.closeButton.tag = indexPath.row
            cell.configColors(colors: tierLists[indexPath.row].getColorsArray())
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == tierLists.count { return }
        let tiersController = TiersController(tierList: tierLists[indexPath.row], indexP: indexPath)
        navigationController?.pushViewController(tiersController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width-24, height: 120)
    }
}
//MARK: Conform to TierListDelegate
extension MyTierListController: TierListDelegate {
    //Adding new TierList
    func tierListDidChange(newTierList: TierList) {
        ProfileService.shared.addTierList(tierList: newTierList)
    }
}

//MARK: Selector Functions
extension MyTierListController {
    @objc func addButtonPressed(){
        let makeNewTierController = MakeNewTierListController()
        makeNewTierController.delegate = self
        navigationController?.pushViewController(makeNewTierController, animated: true)
    }
}
//MARK: Conform to ProfileServiceSubscriber
extension MyTierListController: ProfileServiceSubscriber {
    func refresh(model: ProfileModel) {
        tierLists = model.tierListArray
        collectionView.reloadData()
    }
}
