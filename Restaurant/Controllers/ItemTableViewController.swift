//
//  ItemTableViewController.swift
//  Restaurant
//
//  Created by Наталья Шарапова on 15.03.2022.
//

import UIKit

class ItemTableViewController: UITableViewController {

    let cellManager = CellManager()
    let networkManager = NetworkManager()
    var category: String!
    var menuItems = [MenuItem]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = category.localizedCapitalized
        
        networkManager.getMenuItems(for: category) { menuItems, error in
            guard let menuItems = menuItems else {
                print(#line, "Error ", terminator: "")
                
                    if let error = error {
                        print(error)
                    } else {
                        print("Cant get items for category \(self.category ?? "nil")")
                    }
                return
            }
            self.menuItems = menuItems
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        
        let menuItem = menuItems[indexPath.row]
        
        cellManager.configure(cell, with: menuItem, for: tableView, indexPath: indexPath)
       
        return cell
    }
    
}
