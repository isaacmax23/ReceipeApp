//
//  ContentView.swift
//  ReceipeApp
//
//  Created by Isaac Maxwell Durairaj on 5/21/24.
//

import SwiftUI

struct ContentView: View {
    @State var dessertList: [Dessert] = [Dessert]()
    var body: some View {
        NavigationSplitView {
            List(dessertList) { dessert in
                VStack {
                    //                Text(dessert.strMeal)
                    NavigationLink {
                        DessertMainView(mealId: dessert.idMeal)
                    } label: {
                        DessertListView(name: dessert.strMeal, url: dessert.strMealThumb)
                    }
                    
                }
                .padding()
            }
            .task {
                dessertList = await ContentViewModel().displayDessertsClicked()!
            }
            .navigationTitle("List")
        } detail: {
            Text("Select a Recipe")
        }
    }
}

#Preview {
    ContentView()
}
