//
//  PromosManager.swift
//  PizzaShop
//
//  Created by Алексей Ревякин on 23.06.2023.
//

import Foundation
import UIKit

class PromosManager {
    static let shared = PromosManager()
    private let promos: [Promo] = [
        Promo(name: "Happy Birthday", imageData: #imageLiteral(resourceName: "HB").pngData(), date: Date()),
        Promo(name: "Monday", imageData: #imageLiteral(resourceName: "monday.png").pngData(), date: Date()),
        Promo(name: "Happy Birthday", imageData: #imageLiteral(resourceName: "HB").pngData(), date: Date())
    ]
    
    func getPromos(completion: @escaping (_ promos: [Promo])->()) {
        completion(promos)
    }
}
