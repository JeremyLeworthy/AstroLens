//
//  ResponseMetadata.swift
//  AstroLens
//
//  Created by Jeremy Leworthy on 2023-06-11.
//

struct ResponseMetadata: Decodable {
	let totalHits: Int
	
	enum CodingKeys: String, CodingKey {
		case totalHits = "total_hits"
	}
}
