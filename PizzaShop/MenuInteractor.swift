//
//  MenuInteractor.swift
//  PizzaShop
//
//  Created by Алексей Ревякин on 23.06.2023.
//

import UIKit

protocol MenuBusinessLogic {
    func getPromos(request: MenuModels.FetchPromos.Request)
    func getCategories(request: MenuModels.FetchCategories.Request)
    func getFoods(request: MenuModels.FetchFood.Request)
}

protocol MenuDataStore {
    var promos: [Promo] { get }
    var categories: [ApiType] { get }
    var foods: Foods { get }
}

class MenuInteractor: MenuBusinessLogic, MenuDataStore {
    
    var promos: [Promo] = []
    
    var categories: [ApiType] = []
    
    var foods: Foods = []
    
    var presenter: MenuPresentaionLogic?
    
    func getPromos(request: MenuModels.FetchPromos.Request) {
        PromosManager.shared.getPromos { promos in
            self.promos = promos
            let response = MenuModels.FetchPromos.Response(promos: promos)
            self.presenter?.presentPromos(response: response)
        }
    }
    
    func getCategories(request: MenuModels.FetchCategories.Request) {
        for category in ApiType.allCases {
            categories.append(category)
        }
        let response = MenuModels.FetchCategories.Response(categories: categories)
        presenter?.presentCategories(response: response)
    }
    
    func getFoods(request: MenuModels.FetchFood.Request) {
        NetworkManager.shared.getFood(foodCategory: request.category) { food in
            let response = MenuModels.FetchFood.Response(foods: food, category: request.category)
            self.presenter?.presentFood(response: response)
        }
    }
}
