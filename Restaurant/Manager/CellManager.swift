//
//  CellManager.swift
//  Restaurant
//
//  Created by Наталья Шарапова on 14.03.2022.
//

import UIKit

class CellManager {
    
    func configure(_ cell: UITableViewCell, with category: String) {
        
        cell.textLabel?.text = category.capitalized
    }
    
    func configure(_ cell: UITableViewCell,
                   with menuItem: MenuItem,
                   for tableView: UITableView,
                   indexPath: IndexPath) {
        
        let networkManager = NetworkManager()
        
        cell.textLabel?.text = menuItem.name
        cell.detailTextLabel?.text = String(format: "$%.2f", (menuItem.price))
        
        guard cell.imageView?.image == nil else { return }
        
        networkManager.getImage(menuItem.imageURL) { image, error in
            if let error = error {
                print(#line, "Error:", error.localizedDescription)
            }
            DispatchQueue.main.async {
                cell.imageView?.image = image
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
    }
    
}
