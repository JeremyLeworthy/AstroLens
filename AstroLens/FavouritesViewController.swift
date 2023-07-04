//
//  FavouritesViewController.swift
//  AstroLens
//
//  Created by Jeremy Leworthy on 2023-03-06.
//

import UIKit

class FavouritesViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		tabBarController?.navigationItem.title = "Favourites"
	}
}
