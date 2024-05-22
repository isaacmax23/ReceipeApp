//
//  ReceipeAPI.swift
//  ReceipeApp
//
//  Created by Isaac Maxwell Durairaj on 5/21/24.
//

import Foundation
let desserrtsURL = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
let receipeURL = "https://themealdb.com/api/json/v1/1/lookup.php?i="
class ReceipeAPI {
    func fetchDessertList() async throws -> [Dessert] {
        let url = URL(string: desserrtsURL)!
        let (data, _) = try await URLSession.shared.data(from: url)
        let receipe = try JSONDecoder().decode(Receipe.self, from: data)
        return receipe.meals
    }
    
    func fetchReceipe(mealID: String) async throws -> Meal {
//        var meal: [Meal]? = nil
        let url = URL(string: receipeURL + mealID)!
        let (data, _) = try await URLSession.shared.data(from: url)
//        do {
            let meal = try JSONDecoder().decode(MealsResponse.self, from: data)
//        } catch DecodingError.dataCorrupted(let context) {
//            print("Data corrupted: \(context.debugDescription)")
//        } catch DecodingError.keyNotFound(let key, let context) {
//            print("Key '\(key)' not found: \(context.debugDescription)")
//        } catch DecodingError.typeMismatch(let type, let context) {
//            print("Type '\(type)' mismatch: \(context.debugDescription)")
//        } catch DecodingError.valueNotFound(let type, let context) {
//            print("Value '\(type)' not found: \(context.debugDescription)")
//        } catch {
//            print("Failed to decode JSON: \(error.localizedDescription)")
//        }
        return meal.meals[0]
    }
}
