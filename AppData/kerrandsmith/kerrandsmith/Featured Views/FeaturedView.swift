//
//  FeaturedView.swift
//  kerrandsmith
//
//  Created by Sean Kelly on 15/05/2023.
//

import SwiftUI

struct FeaturedView: View {
    
    @Binding var forceRefresh: Bool
    
    var body: some View {
        VStack {
           
            FeaturedNews()
            
            FeaturedScrollViewCars(forceRefresh: $forceRefresh)
            
            FeaturedScrollViewVans(forceRefresh: $forceRefresh)
            
            FeaturedNews2()
                .padding(.top)
            
            FeaturedScrollViewTrailers(forceRefresh: $forceRefresh)
               
            Rectangle()
                .foregroundColor(.clear)
                .frame(height: 120)
        }
    }
}

