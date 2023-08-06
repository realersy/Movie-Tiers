//
//  InventoryController.swift
//  MovieTiers
//
//  Created by Ersan Shimshek on 26.07.2023.
//

import Foundation
import UIKit

final class InventoryController: UIViewController {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.minimumInteritemSpacing = 6
        layout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        return collection
    }()
    var myInventory: [Item]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myInventory = FileService.shared.readModel()
        collectionView.reloadData()
        collectionView.backgroundColor = UIColor("#33377A")
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        myInventory = FileService.shared.readModel()
        collectionView.reloadData()
    }
    
    convenience init(items: [Item]){
        self.init(nibName: nil, bundle: nil)
        self.myInventory = items
        
    }
}

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
        navigationController?.pushViewController(MoviePosterController(title!,
                                                                       image!,
                                                                       myInventory!,
                                                                       indexPath.row), animated: true)
    }
}

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

extension InventoryController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width / 3) - 24
        return CGSize(width: width, height: width*1.6)
    }
}
