//
//  FeaturedHeader.swift
//  kerrandsmith
//
//  Created by Sean Kelly on 16/05/2023.
//

import SwiftUI

struct FeaturedHeader: View {
    
    let featuredText: String
    
    var body: some View {
        HStack {
            Text(featuredText)
                .font(.title3)
                .fontWeight(.bold)
                
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top)
    }
}

