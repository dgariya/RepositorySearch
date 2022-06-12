import UIKit
import WebKit

class RepositorySearchViewController: UIViewController, WKNavigationDelegate, SearchResultDelegate {
    
    var delegate:SearchResultDelegate?
    
    var searchController = UISearchController(searchResultsController: SearchResultTableViewController())
    var filteredRepositorys : [String] = []
    
    // Debouncing using Dispatch Work item
    var searchTask: DispatchWorkItem?
    
    @IBOutlet var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Repositories Search"
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search repositories"
        definesPresentationContext = true
    }
    
    func openSelectedRepository(repsitoryUrl: URL?) {
        if let repsitoryUrl = repsitoryUrl {
            webView.load(URLRequest(url: repsitoryUrl))
            webView.allowsBackForwardNavigationGestures = true
        }
    }
}

extension RepositorySearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            self.searchTask?.cancel()
            let task = DispatchWorkItem {
                let viewController = searchController.searchResultsController as? SearchResultTableViewController
                viewController?.delegate = self
                viewController?.fetchRepositories(searchQuerry: searchText)
            }
            self.searchTask = task
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: task)
        }
    }
}
