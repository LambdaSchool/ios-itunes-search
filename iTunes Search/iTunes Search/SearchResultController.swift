//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Sameera Leola on 12/11/18.
//  Copyright © 2018 Sameera Leola. All rights reserved.
//

import Foundation

class SearchResultController {
    
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    
    // MARK: Data source
    var searchResults: [SearchResult] = []
    
    func performSearch(with searchTerm: String, resultType: ResultType, completion: @escaping (NSError?) -> Void) {
        
        //Create the components
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) // <- resolvingAgainstBaseURLT is always true
        
        // Create the necessary iTunes query parameters in the form of URLQueryItem
        let queryItemSearchTerm = URLQueryItem(name: "term", value: searchTerm)
        let queryItemCountry = URLQueryItem(name: "country", value: "US")
       // let queryItemMedia = URLQueryItem(name: "media", value: "")
        let queryItemEntity = URLQueryItem(name: "entity", value: resultType.rawValue)
       // let queryItemAttribute = URLQueryItem(name: "attribute", value: "")
        let queryItemLimit = URLQueryItem(name: "limit", value: "10")
        let queryItemLanguage = URLQueryItem(name: "lang", value: "en_us")
        
        //components?.queryItems = [queryItemSearchTerm, queryItemCountry, queryItemMedia, queryItemEntity, queryItemAttribute, queryItemLimit, queryItemLanguage]
        components?.queryItems = [queryItemSearchTerm, queryItemCountry, queryItemEntity, queryItemLimit, queryItemLanguage]
        
        //Create the URL
        guard let requestURL = components?.url else {
            NSLog("Unable to make iTunes search request URL")
            completion(NSError())
            return
        }
        
        //Make the request
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching iTunes data: \(error)")
                //completion(error)
                completion(nil)
                return
            }
            
            //No data
            guard let data = data else {
                NSLog("No data returned from data task")
                completion(NSError())
                return
            }
            
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            //Decode the data
            do {
                let itunesData = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = itunesData.results
                //completion(error)
                completion(nil)
                return
            }
            catch {
                NSLog("Unable to decode data: \(error)")
                completion(nil)
                return
            }
        }
        
        dataTask.resume()
        
        
        
        
        
        
    }
} //End of class
