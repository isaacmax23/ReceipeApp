//
//  OnboardingView.swift
//  ReceipeApp
//
//  Created by Isaac Maxwell Durairaj on 5/23/24.
//

import Foundation
import SwiftUI

struct OnboardingView: View {
    var body: some View {
        VStack{
            Image("cookies")
                .clipShape(.circle)
            Text("Recipe App!")
                .font(.title)
                .fontWeight(.bold)
                .padding()
        }
    }
}
