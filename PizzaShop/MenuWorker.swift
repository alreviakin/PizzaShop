//
//  MenuWorker.swift
//  PizzaShop
//
//  Created by Алексей Ревякин on 23.06.2023.
//

import Foundation

class MenuWorker {
    func getImageData(from promos: [Promo]) -> MenuModels.FetchPromos.ViewModel {
        var imageData: [Data] = []
        for promo in promos {
            imageData.append(promo.imageData ?? Data())
        }
        return MenuModels.FetchPromos.ViewModel(imageData: imageData)
    }
    
    func getFoodDisplay(foods: Foods) -> [MenuModels.FetchFood.ViewModel.FoodDisplay] {
        var foodsDisplay: [MenuModels.FetchFood.ViewModel.FoodDisplay] = []
        foods.forEach { food in
            guard let name = food.name, let cost = food.price, let description = food.dsc else { return }
            let foodDisplay = MenuModels.FetchFood.ViewModel.FoodDisplay(
                image: getImage(from: food.img) ?? Data(),
                name: name,
                description: description,
                cost: "от \(cost)")
            foodsDisplay.append(foodDisplay)
        }
        return foodsDisplay
    }
    
    private func getImage(from imageURL: String?) -> Data? {
        return ImageManager.shared.getImageData(from: imageURL)
    }
}
