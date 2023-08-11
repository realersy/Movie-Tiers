//
//  InventoryController.swift
//  MovieTiers
//
//  Created by Ersan Shimshek on 26.07.2023.
//

import Foundation
import UIKit

final class InventoryController: UIViewController {
    //MARK: Parameters
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.minimumInteritemSpacing = 6
        layout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        return collection
    }()
    var myInventory: [Item]?
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.reloadData()
        collectionView.backgroundColor = UIColor("#33377A")
        setupCollectionView()
    }
    //MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    //MARK: Custom Init
    convenience init(items: [Item]){
        self.init(nibName: nil, bundle: nil)
        self.myInventory = items
        
    }
}
//MARK: UICollection View Delegate/DataSource
extension InventoryController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myInventory?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchMovieCell.cellID, for: indexPath) as! SearchMovieCell
        cell.imageView.image = UIImage(data: myInventory![indexPath.row].imageData)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let title = myInventory?[indexPath.row].title
        let image = myInventory?[indexPath.row].imageData
        let moviePosterController = MoviePosterController(title!,
                                                           image!,
                                                           myInventory!,
                                                           indexPath.row)
        moviePosterController.itemsDelegate = self
        navigationController?.pushViewController(moviePosterController, animated: true)
    }
}
//MARK: Setup
private extension InventoryController {
    func setupCollectionView(){
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SearchMovieCell.self, forCellWithReuseIdentifier: SearchMovieCell.cellID)
        collectionView.alwaysBounceVertical = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
//MARK: UICollectionViewDelegateFlowLayout
extension InventoryController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width / 3) - 24
        return CGSize(width: width, height: width*1.6)
    }
}
//MARK: Conform to ProfileServiceSubscriber
extension InventoryController: ProfileServiceSubscriber {
    func refresh(model: ProfileModel) {
        myInventory = model.inventory
        collectionView.reloadData()
    }
}
//MARK: Refresh Inventory
extension InventoryController: ItemsDelegate {
    func itemsDidChange(newInventory: [Item]) {
        myInventory = newInventory
    }
}
