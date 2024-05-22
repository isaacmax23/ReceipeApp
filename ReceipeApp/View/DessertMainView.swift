//
//  DessertMainView.swift
//  ReceipeApp
//
//  Created by Isaac Maxwell Durairaj on 5/21/24.
//

import Foundation
import SwiftUI

struct DessertMainView: View {
    @State var meal: Meal? = nil
    let mealId: String
    var body: some View {
        VStack {
            Text(meal?.strMeal ?? "")
            Text("Lol")
            if let ing = meal?.ingredients {
                let n = ing.count
                List(0 ..< n) {i in
                    Text(ing[i])
                }
            }
        }
        .task {
            do{
             meal  =  try await ReceipeAPI().fetchReceipe(mealID: mealId)
            } catch {
                
            }
        }
    }
}
