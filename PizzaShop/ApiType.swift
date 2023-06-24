//
//  ApiType.swift
//  PizzaShop
//
//  Created by Алексей Ревякин on 24.06.2023.
//

import Foundation

enum ApiType: String, CaseIterable {
    case pizzas
    case burgers
    case desserts
    case drinks
    
    var stirngUrl:String {
        return "https://free-food-menus-api-production.up.railway.app/" + self.rawValue + "?_limit=10"
    }
}
