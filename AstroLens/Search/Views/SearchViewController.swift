//
//  SearchViewController.swift
//  AstroLens
//
//  Created by Jeremy Leworthy on 2023-03-06.
//

import UIKit

class SearchViewController: UIViewController {
	
	private lazy var searchBar: UITextField = {
		let textField = UITextField()
		textField.backgroundColor = .white
		textField.textColor = .black
		textField.attributedPlaceholder = NSAttributedString(string: "Search for a keyword", attributes: [.foregroundColor: UIColor.black])
		textField.borderStyle = .roundedRect
		textField.delegate = viewModel
		textField.translatesAutoresizingMaskIntoConstraints = false
		return textField
	}()
	
	private let viewModel: SearchViewModel
	
	init(viewModel: SearchViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		
		view.addSubview(searchBar)
		
		let navHeight = navigationController?.navigationBar.frame.maxY ?? 0
		
		NSLayoutConstraint.activate([
			searchBar.height(constant: 44),
			searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: navHeight + 50),
			searchBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
			searchBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32)
		])
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		tabBarController?.navigationItem.title = "Search"
	}
}
