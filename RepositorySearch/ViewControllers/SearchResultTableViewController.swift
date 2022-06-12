import UIKit

protocol SearchResultDelegate {
    func openSelectedRepository(repsitoryUrl:URL?)
}

class SearchResultTableViewController: UITableViewController {
  
    var delegate: SearchResultDelegate?
    var repositories = [Repository]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        tableView.register(RepositoryTableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    func fetchRepositories(searchQuerry: String) {
        
        guard !searchQuerry.isEmpty else {
            repositories = []
            tableView.reloadData()
            return
        }
        
        ServiceHandler(query: searchQuerry).request { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.repositories = response.repositories
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repositories.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RepositoryTableViewCell
        cell.repositoryTitleView.text = self.repositories[indexPath.row].fullName
        let imageStr = self.repositories[indexPath.row].owners.avatar_url
        cell.avatoreImageView.downloadImageWithUrl(imagePath: imageStr)
        cell.avatoreImageView.contentMode = .scaleAspectFit
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let urlString = self.repositories[indexPath.row].webUrl {
            delegate?.openSelectedRepository(repsitoryUrl: URL(string: urlString)!)
            self.dismiss(animated: true, completion: nil)
        }
    }
}
