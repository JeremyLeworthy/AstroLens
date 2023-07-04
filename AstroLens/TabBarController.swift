//
//  TabBarController.swift
//  AstroLens
//
//  Created by Jeremy Leworthy on 2023-03-06.
//

import UIKit

class TabBarController: UITabBarController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let tab1 = ExploreViewController(viewModel: ExploreViewModel(networkManager: NetworkManager()))
		tab1.tabBarItem = UITabBarItem(title: "Explore", image: UIImage(systemName: "globe.americas"), selectedImage: UIImage(systemName: "globe.americas.fill"))
		
		let tab2 = SearchViewController(viewModel: SearchViewModel(networkManager: NetworkManager()))
		tab2.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass.circle"), selectedImage: UIImage(systemName: "magnifyingglass.circle.fill"))
		
		let tab3 = FavouritesViewController()
		tab3.tabBarItem = UITabBarItem(title: "Favourites", image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))
		
		viewControllers = [tab1, tab2, tab3]
		selectedIndex = 0
		
		let appearance = UITabBarAppearance()
		appearance.configureWithOpaqueBackground()
		
		tabBar.tintColor = .label
		tabBar.standardAppearance = appearance
		tabBar.scrollEdgeAppearance = appearance
	}
}

