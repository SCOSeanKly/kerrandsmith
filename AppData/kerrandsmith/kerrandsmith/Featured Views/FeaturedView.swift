//
//  FeaturedView.swift
//  kerrandsmith
//
//  Created by Sean Kelly on 15/05/2023.
//

import SwiftUI

struct FeaturedView: View {
    
    var body: some View {
        VStack {
            
            FeaturedNews()
            
            FeaturedHeader(featuredText: "Featured Cars")
            
            FeaturedScrollViewCars()
            
            FeaturedHeader(featuredText: "Featured Vans")
            
            FeaturedScrollViewVans()
            
            FeaturedNews2()
                .padding(.top)
            
            FeaturedHeader(featuredText: "Featured Trailers")
            
            FeaturedScrollViewTrailers()
        }
    }
}

