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
    let url: String?
    let qty: String?
    var body: some View {
        HStack{
            if let url = url {
              
                    AsyncImage(url: URL(string: url)) { image in
                        image.resizable()
                    } placeholder: {
                        Text("No Image :(")
                    }
                    .frame(width: 128, height: 128)
                    .clipShape(.rect(cornerRadius: 25))
//                    Text(name)
//                }
            }
//        else{
//            HStack{
                Text(name)
                    .frame(maxWidth: .infinity,alignment: .leading)
                if let qty = qty {
                    Text(qty)
                }
            }
            .padding(.all)
            
    }
}
