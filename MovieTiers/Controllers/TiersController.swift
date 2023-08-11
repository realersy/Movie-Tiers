//
//  TiersController.swift
//  MovieTiers
//
//  Created by Ersan Shimshek on 07.08.2023.
//

import Foundation
import UIKit

final class TiersController: UIViewController {
    
    //MARK: Parameters
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.minimumInteritemSpacing = 6
        layout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        return collection
    }()
    
    var tierIndex: Int?
    var tierList: TierList?
    var indexP: IndexPath?
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor("#33377A")
        setup()
    }
    //MARK: Init
    init(tierList: TierList, indexP: IndexPath) {
        super.init(nibName: nil, bundle: nil)
        self.tierList = tierList
        self.indexP = indexP
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
//MARK: Setup
extension TiersController {
    private func setup(){
        
        title = tierList?.title
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TiersCell.self, forCellWithReuseIdentifier: TiersCell.cellID)
    }
}

//MARK: UICollection View Delegate/DataSource + UICollectionViewDelegateFlowLayout
extension TiersController: UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (tierList?.tierList.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TiersCell.cellID, for: indexPath) as! TiersCell
        cell.ip = indexPath
        cell.tierListIndex = indexP
        cell.tiersCellDelegate = self
        cell.tier = (tierList?.tierList[indexPath.row])!
        cell.tierNameLabel.text = tierList?.tierList[indexPath.row].name
        cell.backgroundColor = UIColor((tierList?.tierList[indexPath.row].colorHex)!)
        cell.collectionView.backgroundColor = UIColor((tierList?.tierList[indexPath.row].colorHex)!)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 24, height: 280)
    }
}
//MARK: TiersCellDelegate
extension TiersController: TiersCellDelegate {
    //Makes sure the picker view is presented in this controller
    func presentPicker(index: Int) {
        let picker = UIPickerView()
        tierIndex = index
        picker.delegate = self
        picker.dataSource = self
        picker.layer.cornerRadius = 22
        picker.backgroundColor = .systemGray2
        view.addSubview(picker)
        picker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            picker.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70),
            picker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            picker.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
//MARK: UIPickerViewDataSource, UIPickerViewDelegate
extension TiersController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ProfileService.shared.getModelInventory().count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ProfileService.shared.getModelInventory()[row].title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if ProfileService.shared.getModelInventory().count == 0 {
            return
        }
        let item = Item(imageData: ProfileService.shared.getModelInventory()[row].imageData, title: ProfileService.shared.getModelInventory()[row].title)
            ProfileService.shared.addItemToTierList(item: item, tierListIndex: (indexP?.row)!, tierIndex: tierIndex!)
        (collectionView.cellForItem(at: IndexPath(row: tierIndex!, section: 0)) as! TiersCell).tier = ProfileService.shared.getTierList(index: indexP!.row).tierList[tierIndex!]
        (collectionView.cellForItem(at: IndexPath(row: tierIndex!, section: 0)) as! TiersCell).collectionView.reloadData()
        pickerView.removeFromSuperview()
    }
}
