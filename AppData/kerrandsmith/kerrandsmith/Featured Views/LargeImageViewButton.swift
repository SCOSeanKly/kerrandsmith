//
//  LargeImageViewButton.swift
//  kerrandsmith
//
//  Created by Sean Kelly on 07/06/2023.
//

import SwiftUI

struct LargeImageViewButton: View {
    
    let systemImage: String
    
    let imageWidth: CGFloat
    let imageHeight: CGFloat
    let tintColour: Color
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Image(systemName: systemImage)
                    .font(.headline)
                    .foregroundColor(tintColour)
                    .shadow(radius: 2)
            }
            .padding()
        }
        .frame(width: imageWidth, height: imageHeight, alignment: .center)
        .padding(.bottom, 5.0)
    }
}
