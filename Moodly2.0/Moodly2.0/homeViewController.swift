import UIKit
import SideMenu

class homeViewController: UIViewController {
    var menu: SideMenuNavigationController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        menu = SideMenuNavigationController(rootViewController: menuListController())
        menu?.leftSide = true
        menu?.setNavigationBarHidden(true, animated: false)
        
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
    }

    @IBAction func didTapMenu(_ sender: Any) {
        present(menu!, animated: true)
    }
}

class menuListController: UITableViewController {
    var items = ["My Accont", "Read about", "Log Out"]
    
    let menuBackgroundColor = UIColor(
        red: 1.0,
        green: 0.5,
        blue: 0,
        alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = menuBackgroundColor
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = menuBackgroundColor
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
