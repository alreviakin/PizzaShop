//
//  Resources.swift
//  PizzaShop
//
//  Created by Алексей Ревякин on 23.06.2023.
//

import Foundation
import UIKit

enum R {
    enum Color {
        static let colorB1 = UIColor(hexString: "#FD3A69")
        static let generalFont = UIColor(hexString: "#222831")
        static let separatot = UIColor(hexString: "#F3F5F9")
        static let descriptionFont = UIColor(hexString: "#AAAAAD")
        static let inactive = UIColor(hexString: "#C3C4C9")
        static let viewBackground =  UIColor(hexString: "#F3F5F9")
        static let selectedCategoryCell = UIColor(hexString: "#FD3A69", alpha: 0.2)
        static let deselectedCategoryCell = UIColor(hexString: "#FD3A69", alpha: 0.4)
    }
    
    enum Image {
        static let menu = #imageLiteral(resourceName: "menu")
        static let contacts = #imageLiteral(resourceName: "contans")
        static let profile = #imageLiteral(resourceName: "profile")
        static let bascet = #imageLiteral(resourceName: "bascet")
        static let arrow = #imageLiteral(resourceName: "arrow")
    }
    
    enum Strings {
        static let menu = "Меню"
        static let contacts = "Контаты"
        static let profile = "Пофиль"
        static let bascet = "Корзина"
    }
}
