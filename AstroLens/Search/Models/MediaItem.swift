//
//  SearchResult.swift
//  AstroLens
//
//  Created by Jeremy Leworthy on 2023-06-11.
//

struct MediaItem: Decodable {
	let href: String
	let data: [MediaMetadata]?
	let links: [NASALink]?
}
