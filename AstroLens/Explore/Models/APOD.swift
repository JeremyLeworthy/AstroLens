//
//  APOD.swift
//  AstroLens
//
//  Created by Jeremy Leworthy on 2023-03-04.
//

/// Astronomy Picture of the Day
struct APOD: Decodable {
	let copyright: String?
	let date: String
	let explanation: String
	let hdURL: String?
	let mediaType: MediaType
	let serviceVersion: String
	let title: String
	let url: String
	
	enum CodingKeys: String, CodingKey {
		case copyright, date, explanation, title, url
		case hdURL = "hdurl"
		case mediaType = "media_type"
		case serviceVersion = "service_version"
	}
}
