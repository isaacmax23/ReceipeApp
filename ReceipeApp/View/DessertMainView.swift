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
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    let mealId: String
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                AsyncImage(url: URL(string: meal?.strMealThumb ?? "")) { image in
                    image.resizable()
                } placeholder: {
                    Text("No Image :(")
                }
                .frame(width: 128, height: 128)
                .clipShape(.circle)
                .padding(.bottom)
                
                Text(meal?.strInstructions ?? "")
                    .padding(.bottom)
                if let ingredients = meal?.ingredients, let qty = meal?.paddedMeasures {
                    LazyVGrid(columns: columns) {
                        Text("Ingredients")
                            .bold()
                            .font(.title2)
                        Text("Quantity")
                            .bold()
                            .font(.title2)
                        Divider()
                        Divider()
                        ForEach(Array(0..<ingredients.count), id: \.self) { i in
                            Text(ingredients[i])
                            Text(qty[i])
                            Divider()
                            Divider()
                        }
                    }
                    .padding(.all)
                }
            }
        }
        .padding(.all)
        .task {
            do{
             meal = try await ReceipeAPI().fetchReceipe(mealID: mealId)
            } catch {
                meal = nil
            }
        }
    }
}
