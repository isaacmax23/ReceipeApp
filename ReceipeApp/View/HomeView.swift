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
    @State private var isOnboardingComplete = false
    
    var body: some View {
        if !isOnboardingComplete {
            OnboardingView()
                .onAppear {
                   // Use a Timer to change the view to home after 5 seconds
                   DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                       isOnboardingComplete = true
                   }
               }
        } else {
            NavigationView {
                VStack {
                    ClippedTextField(text: $searchText)
                        .padding([.leading,.trailing])
                    
                    ScrollViewReader { proxy in
                        HStack {
                            List(dessertList.filter {
                                self.searchText.isEmpty ||
                                $0.strMeal.localizedCaseInsensitiveContains(searchText)
                            }) { dessert in
                                NavigationLink {
                                    DessertMainView(mealId: dessert.idMeal)
                                        .navigationBarTitle(dessert.strMeal, displayMode: .inline)
                                } label: {
                                    DessertListView(name: dessert.strMeal, url: dessert.strMealThumb, qty: nil)
                                }
                            }
                            Spacer()
                            ScrollIndexView(dessertList: dessertList , proxy: proxy)
                        }
                    }
                    .padding()
                    .task {
                        dessertList = await ContentViewModel().loadDessertsList()!
                    }
                    .navigationTitle("Receipes")
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .listStyle(PlainListStyle())
        }
    }
}

// TextField can be reused
struct ClippedTextField: View {
    @Binding var text: String
    
    var body: some View {
        TextField("Enter text", text: $text)
            .padding(5)
            .background(Color.gray.opacity(0.3))
            .cornerRadius(10)
    }
}

// scroll index can be reused
struct ScrollIndexView: View {
    var dessertList: [Dessert]
    var proxy: ScrollViewProxy
    @State private var selectedLetter: String? = nil
    
    private var alphabet: [String] {
        return Array(Set(dessertList.compactMap { $0.strMeal.prefix(1).uppercased() })).sorted()
    }
    
    // Index letter and first meal that matches it
    private  var alphabetMealDict: [String: String] {
        var map = [String: String]()
        for dessert in dessertList {
           let letter = String(dessert.strMeal.prefix(1)).uppercased()
           if map[letter] == nil {
               map[letter] = dessert.idMeal
           }
        }
        return map
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack {
                ForEach(alphabet, id: \.self) { letter in
                        Text(letter)
                            .font(.headline)
                            .padding(.vertical, 4)
                            .foregroundColor(selectedLetter == letter ? .blue : .primary)
                            .onTapGesture {
                                selectedLetter = letter
                                let dessertId = alphabetMealDict[letter]
                                if let id = dessertId {
                                    withAnimation {
                                        proxy.scrollTo(id, anchor: .top)
                                    }
                                }
                            }
                }
            }
            .frame(width: 30,alignment: .trailing)
        }
    }
}

#Preview {
    HomeView()
}
