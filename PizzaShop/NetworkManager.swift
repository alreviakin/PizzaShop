//
//  NetworkManager.swift
//  PizzaShop
//
//  Created by Алексей Ревякин on 23.06.2023.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    func getFood(foodCategory: ApiType, completion: @escaping (Foods)->()) {
        var stringUrl = ""
        switch foodCategory {
        case .pizzas:
            stringUrl = ApiType.pizzas.stirngUrl
        case .burgers:
            stringUrl = ApiType.burgers.stirngUrl
        case .desserts:
            stringUrl = ApiType.desserts.stirngUrl
        case .drinks:
            stringUrl = ApiType.drinks.stirngUrl
        }
        guard let url = URL(string: stringUrl) else { return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completion([])
            } else if let data, let burgers = try? JSONDecoder().decode(Foods.self, from: data){
                completion(burgers)
            }
        }.resume()
    }
}
