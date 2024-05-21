//
//  DataModel.swift
//  ReceipeApp
//
//  Created by Isaac Maxwell Durairaj on 5/21/24.
//

import Foundation

struct Receipe: Codable {
    let meals: [Dessert]
}

struct Dessert: Codable, Identifiable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
    
    var id: String {
        return idMeal
    }
}
