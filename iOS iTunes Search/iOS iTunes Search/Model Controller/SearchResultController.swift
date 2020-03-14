//
//  SearchResultController.swift
//  iOS iTunes Search
//
//  Created by Elizabeth Thomas on 3/13/20.
//  Copyright © 2020 Libby Thomas. All rights reserved.
//

import Foundation

class SearchResultController {
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    // MARK: - Properties
    var searchResults: [SearchResult] = []
    private let baseURL = URL(string: "https://itunes.apple.com/search")!
    
    // MARK: - Functions
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping () -> Void ) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let resultTermQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        urlComponents?.queryItems = [searchTermQueryItem, resultTermQueryItem]
        
        guard let requestURL = urlComponents?.url else {
            print("Request URL is nil")
//            completion()
            return
        }
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            guard error == nil else {
                print("Error fetching data: \(error)")
//                completion()
                return
            }
            
            guard let data = data else {
                print("Error: No data returned from data task.")
                completion()
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let searchResult = try jsonDecoder.decode(SearchResults.self, from: data)
//                self.searchResults.append(contentsOf: searchResult.results)
                self.searchResults = searchResult.results
            } catch {
                print("Unable to decode data: \(error)")
//                completion(error)
            }
            completion()
        }
        .resume()
    }
}
