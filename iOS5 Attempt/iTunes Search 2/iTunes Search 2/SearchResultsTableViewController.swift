import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    let searchResultsController = SearchResultController()
    
    let reuseIdentifier = "ResultCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultsController.searchResults.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        let searchResult = searchResultsController.searchResults[indexPath.row]
        
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.creator
        
        guard let url = URL(string: searchResult.artwork),
            let imageData = try? Data(contentsOf: url) else { return cell }
        
        cell.imageView?.image = UIImage(data: imageData)
        
        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        let segmentIndex = segmentedControl.selectedSegmentIndex
        
        var resultType: ResultType!
        
        switch segmentIndex {
        case 0:
            resultType = .apps
        case 1:
            resultType = .music
        default:
            resultType = .movies
        }
        
        searchResultsController.performSearch(searchTerm: searchTerm, resultType: resultType) { _, _ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
