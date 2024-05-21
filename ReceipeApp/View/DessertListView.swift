//
//  DessertListView.swift
//  ReceipeApp
//
//  Created by Isaac Maxwell Durairaj on 5/21/24.
//

import Foundation
import SwiftUI

struct DessertListView: View {
    let name: String
    let url: String
    var body: some View {
        HStack{
            AsyncImage(url: URL(string: url)) { image in
                image.resizable()
            } placeholder: {
                 Text("No Image :(")
            }
            .frame(width: 128, height: 128)
            .clipShape(.rect(cornerRadius: 25))
            Text(name)
        }
    }
}
