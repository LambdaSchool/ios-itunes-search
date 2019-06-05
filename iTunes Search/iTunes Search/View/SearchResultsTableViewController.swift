//
//  SearchResultsTableViewController.swift
//  iTunes Search
//
//  Created by Dillon McElhinney on 9/11/18.
//  Copyright © 2018 Dillon McElhinney. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {
    
    // MARK: - Properties
    let searchResultController = SearchResultController()
    
    private var resultType: ResultType {
        let segment = resultTypeSegmentedControl.selectedSegmentIndex
        if segment == 0 {
            return .software
        } else if segment == 1 {
            return .musicTrack
        } else {
            return .movie
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var resultTypeSegmentedControl: UISegmentedControl!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
    }
    
    // MARK: - UI Methods
    @IBAction func changeResultType(_ sender: Any) {
        performSearch()
    }
    
    // MARK: - Table View Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultController.searchResults.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath)
        let searchResult = searchResultController.searchResults[indexPath.row]

        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.creator
        if let imageData = searchResult.imageData {
            cell.imageView?.image = UIImage(data: imageData)
        }
        
        return cell
    }
    
    // MARK: - UI Search Bar Delegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()

        performSearch()
    }
    
    // MARK: - Private Utility Methods
    private func performSearch() {
        // Make sure there is a search term
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        // If so have the search result controller perform a search
        searchResultController.performSearch(searchTerm: searchTerm, resultType: resultType) { (error) in
            if let error = error {
                NSLog("Error performing search: \(error)")
                return
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
            // Have the search result controller load the image on each result
            for result in self.searchResultController.searchResults {
                self.searchResultController.loadImage(result, completion: { (error) in
                    if let error = error {
                        NSLog("Error loading image: \(error)")
                        return
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                })
            }
        }
    }

}
