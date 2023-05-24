//
//  ContentView.swift
//  kerrandsmith
//
//  Created by Sean Kelly on 15/05/2023.
//

import SwiftUI


struct ContentView: View {
    
    var body: some View {
        VStack {
           // Nothing
        }
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .preferredColorScheme(.light)
            .environment(\.colorScheme, .light) // or .light
            .environment(\.sizeCategory, .small)
    }
}
