//
//  ContentView.swift
//  ReceipeApp
//
//  Created by Isaac Maxwell Durairaj on 5/21/24.
//

import SwiftUI

struct HomeView: View {
    
    @State private var dessertList: [Dessert] = [Dessert]()
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            VStack {
                ClippedTextField(text: $searchText)
                    .padding()
                List(dessertList.filter {
                    self.searchText.isEmpty ||
                    $0.strMeal.localizedCaseInsensitiveContains(searchText)
                }) { dessert in
//                    VStack {
                        NavigationLink {
                            DessertMainView(mealId: dessert.idMeal)
                                .navigationBarTitle(dessert.strMeal, displayMode: .inline)
                        } label: {
                            DessertListView(name: dessert.strMeal, url: dessert.strMealThumb, qty: nil)
                        }
//                    }
                }
                .padding()

                .task {
                    dessertList = await ContentViewModel().displayDessertsClicked()!
                }
                .navigationTitle("Receipes")
            }
        }
        .listStyle(PlainListStyle())
    }
}

struct ClippedTextField: View {
    @Binding var text: String
    
    var body: some View {
        TextField("Enter text", text: $text)
            .padding()
            .background(Color.gray.opacity(0.3))
            .cornerRadius(10)
    }
}

#Preview {
    HomeView()
}
