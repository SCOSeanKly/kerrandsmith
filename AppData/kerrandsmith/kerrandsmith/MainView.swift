//
//  MainView.swift
//  kerrandsmith
//
//  Created by Sean Kelly on 15/05/2023.
//

import SwiftUI


struct MainView: View {
    
    @State private var showBookingForm: Bool = false
    
    var body: some View {
        
        TabView {
            
            ScrollingHeader()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            ServicesView(showBookingForm: $showBookingForm)
                .tabItem {
                    Label("Services", systemImage: "wrench.and.screwdriver.fill")
                }
            
            RecoveryView()
                .tabItem {
                    Label("Recovery", systemImage: "car")
                }
            
            About(showBookingForm: $showBookingForm)
                .tabItem {
                    Label("About", systemImage: "info.circle")
                }
        }
        .prefersPersistentSystemOverlaysHidden()
        .preferredColorScheme(.light)
        .environment(\.colorScheme, .light) // or .light
        .environment(\.sizeCategory, .small)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .preferredColorScheme(.light)
            .environment(\.colorScheme, .light) // or .light
            .environment(\.sizeCategory, .small)
    }
}
