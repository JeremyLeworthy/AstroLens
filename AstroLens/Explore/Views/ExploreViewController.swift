//
//  ExploreViewController.swift
//  AstroLens
//
//  Created by Jeremy Leworthy on 2023-03-04.
//

import UIKit

class ExploreViewController: UIViewController {
	
	private lazy var tableView = ExploreTableView(delegate: viewModel, dataSource: viewModel)
	
	private let viewModel: ExploreViewModel
	
	init(viewModel: ExploreViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
		self.viewModel.delegate = self
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		
		viewModel.fetchData()
		
		view.addSubview(tableView)
		
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: view.topAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		tabBarController?.navigationItem.title = "Explore"
	}
}

extension ExploreViewController: ReloadDelegate {
	func reloadData() {
		tableView.reloadData()
	}
}
