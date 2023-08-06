//
//  SearchMovieController.swift
//  MovieTiers
//
//  Created by Ersan Shimshek on 25.07.2023.
//

import Foundation
import UIKit
import SPIndicator

final class SearchMovieController: UIViewController {
    
    // MARK: Properties
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.minimumInteritemSpacing = 6
        layout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        return collection
    }()
    let searchController = UISearchController()
    var retreivedMovies = [SearchItem]()
    var inventoryMovies = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inventoryMovies = FileService.shared.readModel()
        collectionView.backgroundColor = UIColor("#33377A")
        setupNavigationController()
        setupCollectionView()
    }
}

extension SearchMovieController {
    func setupNavigationController(){
        navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "Find that movie poster..."
    }
}

private extension SearchMovieController {
    func setupCollectionView(){
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SearchMovieCell.self, forCellWithReuseIdentifier: SearchMovieCell.cellID)
        searchController.searchBar.delegate = self
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

extension SearchMovieController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        retreivedMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchMovieCell.cellID, for: indexPath) as! SearchMovieCell
        cell.configImage(item: retreivedMovies[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! SearchMovieCell
        guard let itemTitle = retreivedMovies[indexPath.row].title else { return }
        let itemImage = cell.imageView.image?.jpegData(compressionQuality: 0.4)
        
        for item in inventoryMovies {
            if item.title == itemTitle {
                let indicatorView = SPIndicatorView(title: "Check your Inventory", preset: .error)
                indicatorView.present(duration: 2)
                return
            }
        }
        if itemImage == nil {
            
        }
        inventoryMovies.append(Item(imageData: (itemImage ?? UIImage(named: "notFoundImage")?.jpegData(compressionQuality: 0.4))!, title: itemTitle))
        let vc = InventoryController(items: inventoryMovies)
        vc.tabBarItem.title = "Inventory"
        vc.tabBarItem.image = UIImage(systemName: "tray.full")
        tabBarController?.viewControllers?[1] = vc
        FileService.shared.writeModel(items: inventoryMovies)
        let indicatorView = SPIndicatorView(title: "Added to Inventory", preset: .done)
        indicatorView.present(duration: 2)
        
        print("------------------------")
        inventoryMovies.forEach { item in
            print(item.title)
            print(item.imageData)
        }
    }
}

extension SearchMovieController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        SearchMovieService.shared.getMovies(query: searchBar.text!) { response in
            self.retreivedMovies = response.data ?? []
            self.collectionView.reloadData()
        }
    }
}

extension SearchMovieController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width / 3) - 24
        return CGSize(width: width, height: width*1.6)
    }
}
