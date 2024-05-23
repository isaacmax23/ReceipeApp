//
//  ContentView.swift
//  ReceipeApp
//
//  Created by Isaac Maxwell Durairaj on 5/21/24.
//

import SwiftUI

struct HomeView: View {
    @State var dessertList: [Dessert] = [Dessert]()
    var body: some View {
        NavigationView {
            List(dessertList) { dessert in
                VStack {
                    NavigationLink {
                        DessertMainView(mealId: dessert.idMeal)
                            .navigationBarTitle(dessert.strMeal, displayMode: .inline)
                    } label: {
                        DessertListView(name: dessert.strMeal, url: dessert.strMealThumb, qty: nil)
                    }
                }
                .padding()
            }
            .task {
                dessertList = await ContentViewModel().displayDessertsClicked()!
            }
            .navigationTitle("Receipes")
        }
        .listStyle(PlainListStyle())
    }
}

#Preview {
    HomeView()
}
