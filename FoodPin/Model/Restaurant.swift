//
//  Restaurant+CoreDataProperties.swift
//  FoodPin
//
//  Created by 山本響 on 2021/08/07.
//
//


import Foundation
import CoreData


public class Restaurant: NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Restaurant> {
        return NSFetchRequest<Restaurant>(entityName: "Restaurant")
    }

    @NSManaged public var image: Data
    @NSManaged public var isFavorite: Bool
    @NSManaged public var location: String
    @NSManaged public var name: String
    @NSManaged public var phone: String
    @NSManaged public var ratingText: String?
    @NSManaged public var summary: String
    @NSManaged public var type: String
}

extension Restaurant {
    
    enum Rating: String {
        case awesome
        case good
        case okay
        case bad
        case terrible
        
        var image: String {
            switch self {
            case .awesome: return "love"
            case .good: return "cool"
            case .okay: return "happy"
            case .bad: return "sad"
            case .terrible: return "angry"
            }
        }
    }
    
    var rating: Rating? {
        get {
            guard let ratingText = ratingText else {
                return nil
            }
            
            return Rating(rawValue: ratingText)
        }
        
        set {
            self.ratingText = newValue?.rawValue
        }
    }
}


extension Restaurant : Identifiable {

}
