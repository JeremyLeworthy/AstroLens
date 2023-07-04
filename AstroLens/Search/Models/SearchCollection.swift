//
//  SearchCollection.swift
//  AstroLens
//
//  Created by Jeremy Leworthy on 2023-06-11.
//

struct SearchCollection: Decodable {
	let version: String
	let href: String
	let items: [MediaItem]
	let metadata: ResponseMetadata?
	let links: [NASALink]?
}
