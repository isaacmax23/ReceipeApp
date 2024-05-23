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
    @State private var letterToFirstDessert: [String: String] = [:]

    var body: some View {
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
                                        .id(dessert.idMeal)
                                }
                            }
                            Spacer()
                            ScrollIndexView(dessertList: dessertList, proxy: proxy)
                        }
                    }
                    .padding()
                    .task {
                        dessertList = await ContentViewModel().displayDessertsClicked()!
                    }
                    .navigationTitle("Receipes")
                }
        }
        .listStyle(PlainListStyle())
//        .onAppear {
//                   updateLetterToFirstDessert()
//               }
//               .onChange(of: dessertList) { _ in
//                   updateLetterToFirstDessert()
//               }
    }
    
   
    private  var updateLetterToFirstDessert: [String: String] {
           var map = [String: String]()
           for dessert in dessertList {
               let letter = String(dessert.strMeal.prefix(1)).uppercased()
               if map[letter] == nil {
                   map[letter] = dessert.idMeal
               }
           }
          return map
       }
}

struct ClippedTextField: View {
    @Binding var text: String
    
    var body: some View {
        TextField("Enter text", text: $text)
            .padding(5)
            .background(Color.gray.opacity(0.3))
            .cornerRadius(10)
    }
}

struct ScrollIndexView: View {
    var dessertList: [String]
//    @Binding var dessert: [String]
    var proxy: ScrollViewProxy
    @State private var selectedLetter: String? = nil
    
    private var indexedStrings: [IndexedString] {
        var map: [IndexedString]
        for mealName in dessertList {
            map.append(IndexedString(string: mealName))
        }
        return map
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack {
//                ForEach(Array(dessertList.keys).sorted(), id: \.self) { letter in
                ForEach(indexedStrings, id: \.id) { indexed in
                    let letter = indexed.string
                    Text(letter)
                        .font(.headline)
                        .padding(.vertical, 4)
                        .foregroundColor(selectedLetter == letter ? .blue : .primary)
                        .onTapGesture {
                            selectedLetter = letter
                            let dessert = dessertList.first{ $0.prefix(1).uppercased() == letter }
//                            if let id = dessertList[selectedLetter ?? ""]{
                                withAnimation {
                                    proxy.scrollTo(indexed.id, anchor: .top)
                                }
//                            }
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
