//
//  NetworkManager.swift
//  AstroLens
//
//  Created by Jeremy Leworthy on 2023-03-04.
//

import Foundation

final class NetworkManager {
	
	private let apiKey = URLQueryItem(name: "api_key", value: "DEMO_KEY")
	
	enum Endpoint: String {
		case apod = "https://api.nasa.gov/planetary/apod"
		case mediaSearch = "https://images-api.nasa.gov/"
	}
	
	enum HTTPMethod: String {
		case GET
	}
	
	enum HTTPStatusCode: Int {
		case ok = 200
		case created = 201
		case accepted = 202
		case badRequest = 400
		case unauthorized = 401
		case forbidden = 403
		case notFound = 404
		case tooManyRequests = 429
		
		var isSuccess: Bool { return 200 <= rawValue && rawValue < 300 }
	}
	
	enum NetworkError: Error {
		case invalidRequest
		case failedToGetData
		case badResponse
	}
	
	enum MockError: Error {
		case fileNotFound
	}
	
	private func createRequest(with baseURL: URL?, type: HTTPMethod, query: [URLQueryItem]) throws -> URLRequest {
		guard let baseURL else {
			throw NetworkError.invalidRequest
		}
		
		var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
		components?.queryItems = query
		
		guard let url = components?.url else {
			throw NetworkError.invalidRequest
		}
		
		var request = URLRequest(url: url)
		request.httpMethod = type.rawValue
		request.timeoutInterval = 30
		return request
	}
	
	func getData(from url: URL?, with query: [URLQueryItem] = []) async throws -> Data {
		guard let request = try? createRequest(with: url, type: .GET, query: query) else {
			throw NetworkError.invalidRequest
		}
		
		guard let (data, response) = try? await URLSession.shared.data(for: request) else {
			throw NetworkError.failedToGetData
		}
		
		guard let httpResponse = response as? HTTPURLResponse,
			  let httpStatusCode = HTTPStatusCode(rawValue: httpResponse.statusCode),
			  httpStatusCode.isSuccess else {
			throw NetworkError.badResponse
		}
		
		return data
	}
	
	func getAPODResponse() async throws -> [APOD] {
		let startDate = URLQueryItem(name: "start_date", value: "2023-06-11")
		let endDate = URLQueryItem(name: "end_date", value: "2023-06-17")
		let query: [URLQueryItem] = [apiKey, startDate, endDate]
		let data = try await getData(from: URL(string: Endpoint.apod.rawValue), with: query)
		let apodResponse = try JSONDecoder().decode([APOD].self, from: data)
		return apodResponse
	}
	
	func getMockAPODResponse() throws -> [APOD] {
		if let path = Bundle.main.path(forResource: "MockAPODResponse", ofType: "json") {
			let data = try Data(contentsOf: URL(fileURLWithPath: path))
			let apodResponse = try JSONDecoder().decode([APOD].self, from: data)
			return apodResponse
		} else {
			throw MockError.fileNotFound
		}
	}
	
	func performMediaSearch(with keywords: String) async throws -> SearchResponse {
		let query = [
			URLQueryItem(name: "keywords", value: keywords),
			URLQueryItem(name: "page_size", value: "25")
		]
		let data = try await getData(from: URL(string: Endpoint.mediaSearch.rawValue + "search"), with: query)
		return try JSONDecoder().decode(SearchResponse.self, from: data)
	}
	
	func getMediaLinks(with nasaId: String) async throws -> SearchResponse {
		let data = try await getData(from: URL(string: Endpoint.mediaSearch.rawValue + "asset/" + nasaId))
		return try JSONDecoder().decode(SearchResponse.self, from: data)
	}
}
