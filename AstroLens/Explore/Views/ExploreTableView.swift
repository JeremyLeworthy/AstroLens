//
//  ExploreTableView.swift
//  AstroLens
//
//  Created by Jeremy Leworthy on 2023-03-06.
//

import UIKit

class ExploreTableView: UITableView {

	init(backgroundColour: UIColor? = nil, delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
		super.init(frame: .zero, style: .grouped)
		self.backgroundColor = backgroundColour
		self.delegate = delegate
		self.dataSource = dataSource
		rowHeight = UITableView.automaticDimension
		estimatedRowHeight = 312
		showsVerticalScrollIndicator = false
		separatorStyle = .none
		translatesAutoresizingMaskIntoConstraints = false
		register(ExploreCell.self, forCellReuseIdentifier: ExploreCell.identifier)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
