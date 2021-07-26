//
//  Extention+UITraitCollection.swift
//  FoodPin
//
//  Created by 山本響 on 2021/07/26.
//

import UIKit

extension UITraitCollection {

    public static var isDarkMode: Bool {
        if #available(iOS 13, *), current.userInterfaceStyle == .dark {
            return true
        }
        return false
    }
}
