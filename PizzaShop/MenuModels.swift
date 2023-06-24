//
//  MenuModels.swift
//  PizzaShop
//
//  Created by Алексей Ревякин on 23.06.2023.
//

import Foundation

enum MenuModels {
    enum FetchPromos {
        struct Request {
            
        }
        
        struct Response {
            var promos: [Promo]
        }
        
        struct ViewModel {
            var imageData: [Data]
        }
    }
    
    enum FetchCategories {
        struct Request {
            
        }
        
        struct Response {
            var categories: [ApiType]
        }
        
        struct ViewModel {
            var categories: [String]
        }
    }
    
    enum FetchFood {
        struct Request {
            var category: ApiType
        }
        
        struct Response {
            var foods: Foods
            var category: ApiType
        }
        
        struct ViewModel {
            struct FoodDisplay {
                let image: Data
                let name: String
                let description: String
                let cost: String
            }
            var foods: [FoodDisplay]
            var category: ApiType
        }
    }
}
