//
//  TabBarController.swift
//  MovieTiers
//
//  Created by Ersan Shimshek on 25.07.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = .white
        tabBarController?.selectedIndex = 1
        tabBar.selectedImageTintColor = UIColor("#33377A")
        self.setupTabs()
    }
}

//MARK: Setup the View Controllers of the TabBarController
extension TabBarController {
    func setupTabs(){
        let myTierListController = createNav(title: "My Tier Lists", image: UIImage(systemName: "trophy"), vc: MyTierListController())
        let searchMovieController = createNav(title: "Search", image: UIImage(systemName: "magnifyingglass"), vc: SearchMovieController())
        let inventoryController = createNav(title: "Inventory", image: UIImage(systemName: "tray.full"), vc: InventoryController())
        
        self.setViewControllers([searchMovieController, inventoryController, myTierListController], animated: true)
        self.selectedIndex = 1
    }
    
    func createNav(title: String, image: UIImage?, vc: UIViewController & ProfileServiceSubscriber) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        nav.navigationBar.prefersLargeTitles = true
        nav.navigationBar.isTranslucent = true
        nav.viewControllers.first?.navigationItem.title = title
        nav.navigationBar.tintColor = .white
        ProfileService.shared.subscribe(subscriber: vc)
        return nav
        
    }
}

