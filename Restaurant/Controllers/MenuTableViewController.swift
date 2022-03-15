//
//  MenuTableViewController.swift
//  Restaurant
//
//  Created by Наталья Шарапова on 14.03.2022.
//

import UIKit

class MenuTableViewController: UITableViewController {

    let cellManager = CellManager()
    let networkManager = NetworkManager()
    var categories = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkManager.getCategoies { categories, error in
            
            guard let categories = categories else {
               
                if let error = error {
                    print(#line, "Error", error.localizedDescription)
                } else {
                    print(#line, "Cant load categories")
                }
                return
            }
            
            self.categories = categories
            
            DispatchQueue.main.async {
                
                self.tableView.reloadData()
            }
            }
        }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ItemSegue" else { return }
        
        guard let categoryIndex = tableView.indexPathForSelectedRow else { return }
        let destination = segue.destination as! ItemTableViewController
        
        destination.category = categories[categoryIndex.row]
    }
       
    
   // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cellManager.configure(cell, with: categories[indexPath.row])
     
        return cell
    }
    
    }

