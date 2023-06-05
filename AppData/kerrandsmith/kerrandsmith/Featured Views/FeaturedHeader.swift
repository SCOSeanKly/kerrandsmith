//
//  FeaturedHeader.swift
//  kerrandsmith
//
//  Created by Sean Kelly on 16/05/2023.
//

import SwiftUI

struct FeaturedHeader: View {
    
    let featuredText: String
    let systemImage: String
    let text: String
    
    var body: some View {
        HStack {
            Text(featuredText)
                .font(.title3)
                .fontWeight(.bold)
            
            Spacer()
            
            HStack {
                Image(systemName: systemImage)
                    .font(.headline)
                    .foregroundColor(.gray)
                
                Text(text)
                    .font(.headline)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 6)
            .background(
                RoundedRectangle(cornerRadius: 100)
                    .foregroundColor(.clear)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 100))
            )
        }
        .padding(.horizontal)
        .padding(.top)
    }
}

struct FeaturedHeader_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
          
    }
}


