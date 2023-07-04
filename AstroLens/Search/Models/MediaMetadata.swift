//
//  MediaMetadata.swift
//  AstroLens
//
//  Created by Jeremy Leworthy on 2023-06-11.
//

struct MediaMetadata: Decodable {
	let center: String
	let date: String
	let description: String
	let keywords: [String]
	let location: String?
	let mediaType: MediaType?
	let nasaId: String
	let title: String
	let photographer: String?
	
	enum CodingKeys: String, CodingKey {
		case center, description, keywords, location, title, photographer
		case date = "date_created"
		case mediaType = "media_type"
		case nasaId = "nasa_id"
	}
}

