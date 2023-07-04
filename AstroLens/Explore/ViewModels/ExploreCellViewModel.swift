//
//  ExploreCellViewModel.swift
//  AstroLens
//
//  Created by Jeremy Leworthy on 2023-03-06.
//

import Foundation

class ExploreCellViewModel {
	let url: URL
	let title: String
	let date: String
	let explanation: String
	let mediaType: MediaType
	
	init(url: URL, title: String, date: String, explanation: String, mediaType: MediaType) {
		self.url = url
		self.title = title
		self.date = date
		self.explanation = explanation
		self.mediaType = mediaType
	}
}
