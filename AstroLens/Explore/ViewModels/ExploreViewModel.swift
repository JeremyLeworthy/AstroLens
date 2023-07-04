//
//  ExploreViewModel.swift
//  AstroLens
//
//  Created by Jeremy Leworthy on 2023-05-21.
//

import Foundation
import UIKit

@MainActor class ExploreViewModel: NSObject {
	private (set) var exploreCellViewModels: [ExploreCellViewModel]? {
		didSet {
			delegate?.reloadData()
		}
	}
	
	var delegate: ReloadDelegate?
	
	private let networkManager: NetworkManager
	
	init(networkManager: NetworkManager) {
		self.networkManager = networkManager
	}
	
	func fetchData() {
		Task {
			do {
				let apodResponse = try await networkManager.getAPODResponse()
//				let apodResponse = try networkManager.getMockAPODResponse()
				
				// TODO: Consider adding support for video media type
				exploreCellViewModels = apodResponse.reversed().filter { $0.mediaType == .image }.compactMap { apod in
					guard let url = URL(string: apod.url) else { return nil }
					return ExploreCellViewModel(url: url, title: apod.title, date: apod.date, explanation: apod.explanation, mediaType: apod.mediaType)
				}
			} catch {
				print(error.localizedDescription)
			}
		}
	}
}

// MARK: UITableViewDelegate
extension ExploreViewModel: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		guard let cell = tableView.cellForRow(at: indexPath) as? ExploreCell else { return }
		cell.expanded.toggle()
		tableView.performBatchUpdates(nil)
	}
}

// MARK: UITableViewDataSource
extension ExploreViewModel: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return exploreCellViewModels?.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: ExploreCell.identifier, for: indexPath) as? ExploreCell,
			  let viewModel = exploreCellViewModels?[indexPath.row] else {
			return UITableViewCell()
		}
		cell.viewModel = viewModel
		return cell
	}
}
