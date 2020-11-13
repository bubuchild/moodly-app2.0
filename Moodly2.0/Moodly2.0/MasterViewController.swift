import UIKit

class MasterViewController: UIViewController {
  @IBOutlet var tableView: UITableView!
  @IBOutlet var searchFooter: SearchFooter!
  @IBOutlet var searchFooterBottomConstraint: NSLayoutConstraint!
  
  var services: [Services] = []
  let searchController = UISearchController(searchResultsController: nil)
  var filteredServices: [Services] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    services = Services.services()
    
    // 1
    searchController.searchResultsUpdater = self
    // 2
    searchController.obscuresBackgroundDuringPresentation = false
    // 3
    searchController.searchBar.placeholder = "Search"
    // 4
    navigationItem.searchController = searchController
    // 5
    definesPresentationContext = true
    
    searchController.searchBar.scopeButtonTitles = Services.Number.allCases.map { $0.rawValue }
    searchController.searchBar.delegate = self
    
    let notificationCenter = NotificationCenter.default
    notificationCenter.addObserver(forName: UIResponder.keyboardWillChangeFrameNotification,
                                   object: nil, queue: .main) { (notification) in
                                    self.handleKeyboard(notification: notification) }
    notificationCenter.addObserver(forName: UIResponder.keyboardWillHideNotification,
                                   object: nil, queue: .main) { (notification) in
                                    self.handleKeyboard(notification: notification) }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    if let indexPath = tableView.indexPathForSelectedRow {
      tableView.deselectRow(at: indexPath, animated: true)
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard
      segue.identifier == "ShowDetailSegue",
      let indexPath = tableView.indexPathForSelectedRow,
      let detailViewController = segue.destination as? DetailViewController
      else {
        return
    }
    
    let service: Services
    if isFiltering {
      service = filteredServices[indexPath.row]
    } else {
      service = services[indexPath.row]
    }
    detailViewController.service = service
  }
  
  var isSearchBarEmpty: Bool {
    return searchController.searchBar.text?.isEmpty ?? true
  }
  
  var isFiltering: Bool {
    let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
    return searchController.isActive && (!isSearchBarEmpty || searchBarScopeIsFiltering)
  }
  
  func filterContentForSearchText(_ searchText: String,
                                  phoneNumber: Services.Number? = nil) {
    filteredServices = services.filter { (service: Services) -> Bool in
        let doesCategoryMatch = phoneNumber == .all || service.phoneNumber == phoneNumber
      
      if isSearchBarEmpty {
        return doesCategoryMatch
      } else {
        return doesCategoryMatch && service.name.lowercased().contains(searchText.lowercased())
      }
    }
    
    tableView.reloadData()
  }
  
  func handleKeyboard(notification: Notification) {
    // 1
    guard notification.name == UIResponder.keyboardWillChangeFrameNotification else {
      searchFooterBottomConstraint.constant = 0
      view.layoutIfNeeded()
      return
    }
    
    guard
      let info = notification.userInfo,
      let keyboardFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
      else {
        return
    }
    
    // 2
    let keyboardHeight = keyboardFrame.cgRectValue.size.height
    UIView.animate(withDuration: 0.1, animations: { () -> Void in
      self.searchFooterBottomConstraint.constant = keyboardHeight
      self.view.layoutIfNeeded()
    })
  }
}

extension MasterViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    if isFiltering {
      searchFooter.setIsFilteringToShow(filteredItemCount:
        filteredServices.count, of: services.count)
      return filteredServices.count
    }
    
    searchFooter.setNotFiltering()
    return services.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    let service: Services
    if isFiltering {
      service = filteredServices[indexPath.row]
    } else {
      service = services[indexPath.row]
    }
    cell.textLabel?.text = service.name
    cell.detailTextLabel?.text = service.phoneNumber.rawValue
    return cell
  }
}

extension MasterViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    let phoneNumber = Services.Number(rawValue:
      searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex])
    filterContentForSearchText(searchBar.text!, phoneNumber: phoneNumber)
  }
}

extension MasterViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    let phoneNumber = Services.Number(rawValue:
      searchBar.scopeButtonTitles![selectedScope])
    filterContentForSearchText(searchBar.text!, phoneNumber: phoneNumber)
  }
}
