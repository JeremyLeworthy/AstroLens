//
//  NASALink.swift
//  AstroLens
//
//  Created by Jeremy Leworthy on 2023-06-11.
//

struct NASALink: Decodable {
	let href: String
	let rel: String
	let prompt: String?
	let mediaType: MediaType?
	
	enum CodingKeys: String, CodingKey {
		case href, rel, prompt
		case mediaType = "render"
	}
}
