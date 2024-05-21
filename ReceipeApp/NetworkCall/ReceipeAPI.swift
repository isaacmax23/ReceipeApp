//
//  ReceipeAPI.swift
//  ReceipeApp
//
//  Created by Isaac Maxwell Durairaj on 5/21/24.
//

import Foundation
let desserrtsURL = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
class ReceipeAPI {
    func fetchDessertList() async throws -> [Dessert] {
        let url = URL(string: desserrtsURL)!
        let (data, _) = try await URLSession.shared.data(from: url)
        let receipe = try JSONDecoder().decode(Receipe.self, from: data)
        return receipe.meals
    }
}
