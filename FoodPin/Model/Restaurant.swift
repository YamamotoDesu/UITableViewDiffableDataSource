//
//  Restaurant.swift
//  FoodPin
//
//  Created by 山本響 on 2021/07/25.
//

import Foundation

struct Restaurant:Hashable {
    var name: String = ""
    var type: String = ""
    var location: String = ""
    var phone: String = ""
    var description: String = ""
    var image: String = ""
    var isFavorite: Bool = false
}
