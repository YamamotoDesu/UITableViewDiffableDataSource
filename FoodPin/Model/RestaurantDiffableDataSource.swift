//
//  RestaurantDiffableDataSource.swift
//  FoodPin
//
//  Created by 山本響 on 2021/07/25.
//

import UIKit

//Create an enum which indicates the table sections.
enum Section {
    case all
}

class RestaurantDiffableDataSource: UITableViewDiffableDataSource<Section, Restaurant> {

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
    }
}
