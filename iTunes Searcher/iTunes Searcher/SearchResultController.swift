//
//  SearchResultController.swift
//  iTunes Searcher
//
//  Created by Michael Redig on 5/7/19.
//  Copyright © 2019 Michael Redig. All rights reserved.
//

import Foundation

class SearchResultController {
	let baseURL = URL(string: "https://itunes.apple.com/search")!

	var searchResults = [SearchResult]()

	enum HTTPError: Error {
		case non200StatusCode
		case noData
	}

	func performSearch(with searchTerm: String, resultType: ResultType, completion: @escaping (Error?) -> Void) {

		var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
		let searchQuery = URLQueryItem(name: "term", value: searchTerm)
		let mediaQuery = URLQueryItem(name: "media", value: resultType.rawValue)

		urlComponents?.queryItems = [searchQuery, mediaQuery]

		guard let url = urlComponents?.url else { return }
		let request = URLRequest(url: url)

		fetchMahDatas(with: request) { (data, error) in
			if let error = error {
				completion(error)
			}

			guard let data = data else { return }

			let decoder = JSONDecoder()
			do {
				let results = try decoder.decode(SearchResults.self, from: data)
				self.searchResults = results.results
				completion(nil)
			} catch {
				print("error decoding data: \(error)")
				completion(error)
			}
		}
	}

	func fetchMahDatas(with request: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
		URLSession.shared.dataTask(with: request) { (data, response, error) in
			if let error = error {
				print("error getting url '\(request.url ?? URL(string: "")!)': \(error)")
				completion(nil, error)
				return
			} else if let response = response as? HTTPURLResponse, response.statusCode != 200 {
				print("non 200 http response: \(response.statusCode)")
				let myError = HTTPError.non200StatusCode
				completion(nil, myError)
				return
			}

			guard let data = data else {
				completion(nil, HTTPError.noData)
				return
			}
			completion(data, nil)
		}.resume()
	}
}
