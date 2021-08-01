//
//  NavigationController.swift
//  FoodPin
//
//  Created by 山本響 on 2021/07/31.
//

import UIKit

class NavigationController: UINavigationController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }

}
