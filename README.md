# UITableViewDiffableDataSource-Swift
![platforms](https://img.shields.io/badge/platforms-iOS-333333.svg)  

## Context  
A diffable data source object is a specialized type of data source that works together with your table view object. It provides the behavior you need to manage updates to your table view’s data and UI in a simple, efficient way.  
https://developer.apple.com/documentation/uikit/uitableviewdiffabledatasource  

## Requirement
- Xcode Version 12.4 (12D4e)
- Swift 5  
- iOS 13 and onward

### iPhone Image
<table border="0">
<tr>
<td><img src="https://github.com/YamamotoDesu/UITableViewDiffableDataSource-Swift/blob/main/RocketSim%20Recording%20-%20iPhone%2012%20-%202021-07-25%2015.20.45.gif" width="300"></td>
<td><img src="https://user-images.githubusercontent.com/47273077/126889714-397a476a-7154-4023-947b-411e753a5e5d.png" width="300"></td>
<td><img src="https://user-images.githubusercontent.com/47273077/126889687-a6773867-d972-41cb-88c3-20463e7e833a.png" width="300"></td>
</tr>
</table>

### iPad Image
<table border="0">
<tr>
<td><img src="https://user-images.githubusercontent.com/47273077/126889504-a57cef79-78b6-40ac-914c-335af1b73edf.png" width="600"></td>
<td><img src="https://user-images.githubusercontent.com/47273077/126889569-7821efaa-9f7f-41bc-aa75-87f074b11fb2.png" width="600"></td>
</tr>
</table>



## To connect a diffable data source to a table view
```swift

    lazy var dataSource = configureDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Assign the diffable data source to your table view.
        tableView.dataSource = dataSource
        
        //Generate the current state of the table data by creating a snapshot
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.all])
        snapshot.appendItems(restaurantNames, toSection: .all)
        
        //Call the apply() function of the data source to populate the data
        dataSource.apply(snapshot, animatingDifferences: false)
        
        
    }
    
    func configureDataSource() -> UITableViewDiffableDataSource<Section, String> {
        let cellIdentifier = "favoritecell"
        //Create a UITableViewDiffableDataSource object to connect with your table andprovide the configuration of the table view cells.
        let dataSource = UITableViewDiffableDataSource<Section, String>(
            tableView: tableView,
            cellProvider: { tableView, indexPath, restaurantName in
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
                cell.nameLabel.text = restaurantName
                cell.thumbnailImageView.image = UIImage(named: self.restaurantImages[indexPath.row])
                cell.locationLabel.text = self.restaurantLocations[indexPath.row]
                cell.typeLabel.text = self.restaurantTypes[indexPath.row]
                cell.heartMark.isHidden = !self.restaurantIsFavorites[indexPath.row]
                cell.heartMark.tintColor = UITraitCollection.isDarkMode ? .systemYellow : .blue
                return cell
                
            }
        )
        return dataSource
        
    }
```
