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
          ScrollView {
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
                if let ing = meal?.ingredients, let qty = meal?.measures {
                                    var n = ing.count

                    LazyVGrid(columns: columns) {
                        Text("Ingredients")
                            .bold()

                            .font(.title2)

                        Text("Qty")
                            .bold()

                            .font(.title2)

                        ForEach(Array(0..<n), id: \.self) { i in
                            Text(ing[i])
                            Text(qty[i])
                        }
                    }
                    .padding(.all)
                }
            }
                
        }
        .padding(.all)

        .task {
            do{
             meal  =  try await ReceipeAPI().fetchReceipe(mealID: mealId)
            } catch {
                
            }
        }
    }
}
