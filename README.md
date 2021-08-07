# UITableViewDiffableDataSource-Swift(WIP)
![platforms](https://img.shields.io/badge/platforms-iOS-333333.svg)  
<table border="0">
  <tr>
    <th>Empty</th>
    <th>Registration</th>
    <th>List</th>
    <th>Info</th>
    <th>Routing</th>
    <th>Reviewing</th>
  </tr>
  <tr>
    <td><img src="https://user-images.githubusercontent.com/47273077/128584379-62dd0a99-4eba-408a-9156-5fe0e873fce8.png" height="200" width="100"></td>
    <td><img src="https://user-images.githubusercontent.com/47273077/127940326-0f0e568b-1777-4068-afa5-201df62a0fbb.png" height="200" width="100"></td>
    <td><img src="https://user-images.githubusercontent.com/47273077/127940409-dc79c644-cacf-4b87-89dd-7afd21343baa.png" height="200" width="100"></td>
    <td><img src="https://user-images.githubusercontent.com/47273077/127842062-206fcb6e-ee3e-4a12-8d09-cc1a1ad6321f.png" height="200" width="100"></td>
    <td><img src="https://user-images.githubusercontent.com/47273077/127842758-f36061b3-6516-490a-af98-3a959b9b8436.png" height="200" width="100"></td>
    <td><img src="https://user-images.githubusercontent.com/47273077/127842912-58da18de-0ed4-477b-bd22-587c76eb28d2.png" height="200" width="100"></td>
  </tr>
</table>

## Context  
A diffable data source object is a specialized type of data source that works together with your table view object. It provides the behavior you need to manage updates to your table view’s data and UI in a simple, efficient way.  
https://developer.apple.com/documentation/uikit/uitableviewdiffabledatasource  

## Requirement
- Xcode Version 12.4 (12D4e)
- Swift 5  
- iOS 13 and onward
- Google Font(Nunito Font: https://fonts.google.com/specimen/Nunito)

### iPhone Image
<table border="0">
    <tr>
        <tr>
            <th>Gif image</th>
            <th>Standard</th>
            <th>Dark</th>
        </tr>
        <td><img src="https://github.com/YamamotoDesu/UITableViewDiffableDataSource-Swift/blob/main/RocketSim%20Recording%20-%20iPhone%2012%20-%202021-08-02%2018.18.04.gif" width="300"></td>
        <td><img src="https://user-images.githubusercontent.com/47273077/126889714-397a476a-7154-4023-947b-411e753a5e5d.png" width="300"></td>
        <td><img src="https://user-images.githubusercontent.com/47273077/126889687-a6773867-d972-41cb-88c3-20463e7e833a.png" width="300"></td>
    </tr>
</table>

### iPad Image
<table border="0">
    <tr>
        <tr>
            <th>Standard</th>
            <th>Dark</th>
        </tr>
        <td><img src="https://user-images.githubusercontent.com/47273077/126889504-a57cef79-78b6-40ac-914c-335af1b73edf.png" width="600"></td>
        <td><img src="https://user-images.githubusercontent.com/47273077/126889569-7821efaa-9f7f-41bc-aa75-87f074b11fb2.png" width="600"></td>
    </tr>
</table>
<table border="0">

# Sourcecode
## Modern UITable View
### To connect a diffable data source to a table view(iOS 13 and onward)
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

## Functionality
### Routing With MapKit 
https://github.com/YamamotoDesu/UITableViewDiffableDataSource-Swift/blob/main/FoodPin/Controller/MapViewController.swift
<table border="0">
    <tr>
        <tr>
            <th>Locating</th>
            <th>Routing</th>
        </tr>
        <td><img src="https://user-images.githubusercontent.com/47273077/127778176-1ff08ad5-b5fb-4ad2-a837-97e24a551be6.png" width="300"></td>
        <td><img src="https://user-images.githubusercontent.com/47273077/127778215-fd130ff8-f72a-4565-a9de-94d564b94f99.png" width="300"></td>
    </tr>
</table>
    
### Animation
<table border="0">
    <tr>
        <tr>
            <th>StandardAnimation</th>
            <th>SpringAnimation</th>
        </tr>
        <td><img src="https://github.com/YamamotoDesu/UITableViewDiffableDataSource-Swift/blob/main/RocketSim%20Recording%20-%20iPhone%2012%20-%202021-08-02%2012.38.04.gif" width="300"></td>
        <td><img src="https://github.com/YamamotoDesu/UITableViewDiffableDataSource-Swift/blob/main/RocketSim%20Recording%20-%20iPhone%2012%20-%202021-08-02%2012.25.37.gif" width="300"></td>
    </tr>
</table>

```swift  
    override func viewDidLoad() {
        super.viewDidLoad()
        let moveScaleTransform = getScaleAnimation()
        
        // Make the button invisible
        for rateButton in rateButtons {
            rateButton.transform = moveScaleTransform
            rateButton.alpha = 0
        }
    }
    
    func getScaleAnimation() -> CGAffineTransform {
        let moveRightTransform = CGAffineTransform.init(translationX: 600, y: 0)
        let scaleUpTransform = CGAffineTransform.init(scaleX: 5.0, y: 5.0)
        return scaleUpTransform.concatenating(moveRightTransform)
    }
    
    func setSpringAnimation() {
        
        var delay: TimeInterval = 0.1
        for rateButton in self.rateButtons {
            UIView.animate(withDuration: 0.8, delay: delay, usingSpringWithDamping: 0.2,
                           initialSpringVelocity: 0.3, options: [], animations
                            :{
                                rateButton.alpha = 1.0
                                rateButton.transform = .identity
                            }, completion: nil)
            
            delay += 0.1
        }
        UIView.animate(withDuration: 0.4, delay: 0.1, options: [], animations:
                        {
                            self.closeButton.alpha = 1.0
                        }, completion: nil)
    }
    
    func setStandardAnimation() {
        var delay: TimeInterval = 0.1
        for rateButton in self.rateButtons {
            UIView.animate(withDuration: 0.4, delay: delay, options: [], animations:
                            {
                                rateButton.alpha = 1.0
                                rateButton.transform = .identity
                            }, completion: nil)
            
            delay += 0.1
        }
        
        UIView.animate(withDuration: 0.4, delay: 0.1, options: [], animations:
                        {
                            self.closeButton.alpha = 1.0
                        }, completion: nil)

    }
```
    
### Importing photos with UIImagePickerController  
<img src="https://github.com/YamamotoDesu/UITableViewDiffableDataSource-Swift/blob/main/RocketSim%20Recording%20-%20iPhone%2012%20-%202021-08-03%2009.46.44.gif" width="300">    

https://github.com/YamamotoDesu/UITableViewDiffableDataSource-Swift/blob/main/FoodPin/Controller/NewRestaurantController.swift  
```swift  
extension NewRestaurantController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photoImageView.image = selectedImage
            photoImageView.contentMode = .scaleAspectFit
            photoImageView.clipsToBounds = true
        }
        
        dismiss(animated: true, completion: nil)
    }
}

```

### Returns the swipe actions to display on the leading edge of the row(iOS 11 and onward)
<img src="https://user-images.githubusercontent.com/47273077/127734414-c5409c84-54a4-41e7-9ff1-f140e2185d8b.png" width="200">  
    
```swift  
        
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // Get the selected restaurant
        guard let restaurant = self.dataSource.itemIdentifier(for: indexPath) else {
            return UISwipeActionsConfiguration()
        }
        
        // Favorite action
        let favoriteAction = UIContextualAction(style: .normal, title: "") { (action, sourceView, completionHandler) in
            
            let cell = tableView.cellForRow(at: indexPath) as! RestaurantTableViewCell
            cell.heartMark.isHidden = !restaurant.isFavorite
            cell.heartMark.tintColor = UITraitCollection.isDarkMode ? .systemYellow : .blue
            self.restaurantIsFavorites[indexPath.row] = !restaurant.isFavorite
            tableView.reloadData()
            
            // Call completion handler to dismiss tbe action button
            completionHandler(true)
        }
        
        favoriteAction.backgroundColor = UIColor.systemYellow
        favoriteAction.image = UIImage(systemName: "heart.fill")
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [favoriteAction])
        return swipeConfiguration
    }
```

    
### Returns the swipe actions to display on the trailing edge of the row(iOS 11 and onward)
<img src="https://user-images.githubusercontent.com/47273077/127734624-53845a01-aaf8-448b-8706-58ef3b4de1b0.png" width="200">

```swift
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // Get the selected restaurant
        guard let restaurant = self.dataSource.itemIdentifier(for: indexPath) else {
            return UISwipeActionsConfiguration()
        }
        
        // Delete action
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHandler) in
            
            var snapshot = self.dataSource.snapshot()
            snapshot.deleteItems([restaurant])
            self.dataSource.apply(snapshot, animatingDifferences: true)
            
            // Call completion handler to dismiss tbe action button
            completionHandler(true)
        }
        
        //Share action
        let shareAction = UIContextualAction(style: .normal, title: "Share") { (action, sourceView, completionHandler) in
            let defaultText = "Just checking in at " + restaurant.name
            
            let activityController: UIActivityViewController
            
            if let imageToShare = UIImage(named: restaurant.image) {
                activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
            } else {
                activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
            }
            
            if let popoverController = activityController.popoverPresentationController {
                if let cell = tableView.cellForRow(at: indexPath) {
                    popoverController.sourceView = cell
                    popoverController.sourceRect = cell.bounds
                    
                }
            }
            
            self.present(activityController, animated: true, completion: nil)
            completionHandler(true)
        }
        
        deleteAction.backgroundColor = UIColor.systemRed
        deleteAction.image = UIImage(systemName: "trash")
        
        shareAction.backgroundColor = UIColor.systemOrange
        shareAction.image = UIImage(systemName: "square.and.arrow.up")
        
        // Configure both actions as swipe action
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction, shareAction])
        return swipeConfiguration
    }
```

# Something notes
##  In response to dynamic type changes, change cell dynamically
Reference: Apple's iOS Human Interface Guidelines  
https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/typography/
<table border="0">
    <tr>
        <tr>
            <th>Gif image</th>
            <th>Standard</th>
            <th>Large</th>
        </tr>
        <td><img src="https://github.com/YamamotoDesu/UITableViewDiffableDataSource-Swift/blob/main/RocketSim%20Recording%20-%20iPhone%2011%20-%202021-08-01%2011.10.28.gif" width="300"></td>
        <td><img src="https://user-images.githubusercontent.com/47273077/127757087-ee13e14d-de3a-4203-94be-8cd33b3be284.png" width="300"></td>
        <td><img src="https://user-images.githubusercontent.com/47273077/127757066-2a93286c-307b-4870-9321-1e028f6e6282.png" width="300"></td>
    </tr>
</table>  
    

```swift  
 override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        // perform action here when user changes the text size
        switch self.traitCollection.preferredContentSizeCategory {
        case .extraExtraLarge, .extraExtraExtraLarge, .accessibilityExtraLarge, .accessibilityExtraExtraLarge, .accessibilityExtraExtraExtraLarge:
            self.isDynamicLargeType = true
        case .extraSmall, .small, .medium, .accessibilityMedium, .large, .extraLarge:
            self.isDynamicLargeType = false
        default:
            self.isDynamicLargeType = false
        }
        
        // reload view here when user changes the text size and change cell identifier
        if previousTraitCollection?.preferredContentSizeCategory != traitCollection.preferredContentSizeCategory {
            self.dataSource = configureDataSource()
            self.viewDidLoad()
        }
        
    }
```
<img src="https://user-images.githubusercontent.com/47273077/127757209-bd387b1a-0d27-4b08-8405-07eb0c03763c.png" height="500">

## Set Transparent navigation bar  
<table border="0">
    <tr>
        <tr>
            <th>Before</th>
            <th>Before</th>
            <th>After</th>
            <th>After</th>
        </tr>
        <td><img src="https://user-images.githubusercontent.com/47273077/127757537-71f69247-58b1-4ebf-964e-8c79799775ec.png" width="300"></td>
        <td><img src="https://user-images.githubusercontent.com/47273077/127757552-d6c5ab71-3732-43fe-9d0e-ef04ef4480cc.png" width="300"></td>
        <td><img src="https://user-images.githubusercontent.com/47273077/127757649-e38d34a7-bd78-4e81-827b-b67b204dc761.png" width="300"></td>
        <td><img src="https://user-images.githubusercontent.com/47273077/127757658-a86b94d0-a84b-47ff-9dd9-5d8bb75a3c62.png" width="300"></td>
    </tr>
</table>  

```swift
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.hidesBarsOnSwipe = true
        if #available(iOS 14.0, *) {
          navigationItem.backButtonDisplayMode = .minimal
        } else {
          navigationItem.backButtonTitle = " "
        }
    
        // To customize the navigation bar, you first need to retrieve the currentUINavigationBarAppearance object
        // The standardAppearance property contains thecurrent appearance settings for the standard size navigation bar
        if let appearance = navigationController?.navigationBar.standardAppearance {
            appearance.configureWithTransparentBackground()
            if let customFont = UIFont(name: "Nunito-Bold", size: 40.0) {

                appearance.titleTextAttributes = [.foregroundColor:
                                                    UIColor(named: "NavigationBarTitle")!, .font: customFont]
                appearance.largeTitleTextAttributes = [.foregroundColor:
                                                        UIColor(named: "NavigationBarTitle")!, .font: customFont]
            }

            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let navBarAppearence = UINavigationBarAppearance()
        
        var backButtonImage = UIImage(systemName: "arrow.backword", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20.0, weight: .bold))
        backButtonImage = backButtonImage?.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0))
        
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().standardAppearance = navBarAppearence
        UINavigationBar.appearance().compactAppearance = navBarAppearence
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearence
       
        return true
    }
    
```
<img src="https://user-images.githubusercontent.com/47273077/127757835-53b6a111-9363-44b4-8262-6b9a7a8d324f.png" height="500">

##  To prevent content from becoming overly wide for iPad
```swift
tableView.cellLayoutMarginsFollowReadableWidth = true
```
<table border="0">
<tr>
    <caption>iPad Image</caption>
    <tr>
        <th>tableView.cellLayoutMarginsFollowReadableWidth = false</th>
        <th>tableView.cellLayoutMarginsFollowReadableWidth = true</th>
    </tr>
    <td><img src="https://user-images.githubusercontent.com/47273077/126890181-a65afe2c-01f9-4e3d-9427-b99493329514.png" width="400"></td>
    <td><img src="https://user-images.githubusercontent.com/47273077/126889569-7821efaa-9f7f-41bc-aa75-87f074b11fb2.png" width="400"></td>
    </tr>
</table>

##  Check current userinterfacestyle programmatically
```swift
//-------acronym--------------
    // Called when the iOS interface environment changes.
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
      super.traitCollectionDidChange(previousTraitCollection)

        self.heartMark.tintColor = UITraitCollection.isDarkMode ? .systemYellow : .systemPink
    }
//---------------------


extension UITraitCollection {

    public static var isDarkMode: Bool {
        if #available(iOS 13, *), current.userInterfaceStyle == .dark {
            return true
        }
        return false
    }
}
```

##  Set custom font programmatically
```swift
    @IBOutlet var typeLabel: UILabel! {
        didSet {
            if let cutomFont = UIFont(name: "Nunito-Regular", size: 20.0) {
                typeLabel.font = UIFontMetrics(forTextStyle: .title1).scaledFont(for: cutomFont)
            }
        }
    }
```
<table border="0">
    <tr>
        <tr>
            <th>Setting</th>
            <th>Font Image</th>
        </tr>
        <td><img src="https://user-images.githubusercontent.com/47273077/127729880-97a0541a-cf4e-4f57-b3f0-3ee3df11f574.png" height="500"></td>
        <td><img src="https://user-images.githubusercontent.com/47273077/127729904-3835f995-0a39-4785-8ae2-f12dcd84727c.png" width="300"></td>
    </tr>
</table>
<table border="0">

