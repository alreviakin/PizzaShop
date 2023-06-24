//
//  Pizza.swift
//  PizzaShop
//
//  Created by Алексей Ревякин on 24.06.2023.
//

import Foundation

// MARK: - BurgerElement
struct Food: Codable {
    let id: String?
    let img: String?
    let name, dsc: String?
    let price: Double?
    let rate: Int?
    let country: String?
}

typealias Foods = [Food]
