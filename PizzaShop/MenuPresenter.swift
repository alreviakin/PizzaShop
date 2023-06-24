//
//  MenuPresenter.swift
//  PizzaShop
//
//  Created by Алексей Ревякин on 23.06.2023.
//

import Foundation

protocol MenuPresentaionLogic {
    func presentPromos(response: MenuModels.FetchPromos.Response)
    func presentCategories(response: MenuModels.FetchCategories.Response)
    func presentFood(response: MenuModels.FetchFood.Response)
}

class MenuPresenter: MenuPresentaionLogic {
    
    var viewController: MenuDisplayLogic?
    var worker: MenuWorker?
    
    func presentPromos(response: MenuModels.FetchPromos.Response) {
        worker = MenuWorker()
        guard let viewModel = worker?.getImageData(from: response.promos) else { return }
        viewController?.displayPromos(viewModel: viewModel)
    }
    func presentCategories(response: MenuModels.FetchCategories.Response) {
        var categories: [String] = []
        response.categories.forEach { category in
            switch category {
            case .pizzas:
                categories.append("Пицца")
            case .burgers:
                categories.append("Бургер")
            case .desserts:
                categories.append("Десерт")
            case .drinks:
                categories.append("Напиток")
            }
        }
        let viewModel = MenuModels.FetchCategories.ViewModel(categories: categories)
        viewController?.displayCategories(viewModel: viewModel)
    }
    
    func presentFood(response: MenuModels.FetchFood.Response) {
        worker = MenuWorker()
        guard let worker else { return }
        let foodsDisplay = worker.getFoodDisplay(foods: response.foods)
        let viewModel = MenuModels.FetchFood.ViewModel(foods: foodsDisplay, category: response.category)
        viewController?.displayFood(viewModel: viewModel)
    }
}
