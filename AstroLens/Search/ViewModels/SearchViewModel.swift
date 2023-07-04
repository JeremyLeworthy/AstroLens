//
//  SearchViewModel.swift
//  AstroLens
//
//  Created by Jeremy Leworthy on 2023-06-10.
//

import Foundation
import UIKit

class SearchViewModel: NSObject {
	private let networkManager: NetworkManager
	
	var keywords = [String]()
	
	init(networkManager: NetworkManager) {
		self.networkManager = networkManager
	}
	
	func searchForImages(with keyword: String) {
		keywords.append(keyword)
		
		let query = keywords.joined(separator: ",")
		Task {
			do {
				let searchResponse = try await networkManager.performMediaSearch(with: query)
				for item in searchResponse.collection.items {
					guard let encodedNasaId = item.data?.first?.nasaId.addingPercentEncoding(withAllowedCharacters: .alphanumerics) else { continue }
					let links = try await networkManager.getMediaLinks(with: encodedNasaId)
					print(links)
				}
				
			} catch {
				print(error.localizedDescription)
			}
		}
	}
}

// MARK: - UITextFieldDelegate
extension SearchViewModel: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		if let keyword = textField.text {
			searchForImages(with: keyword)
			textField.text = ""
		}
		
		return true
	}
}
