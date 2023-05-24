//
//  LargeViewButton.swift
//  kerrandsmith
//
//  Created by Sean Kelly on 19/05/2023.
//

import SwiftUI

struct LargeViewButton: View {
    
    let systemImage: String
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Image(systemName: systemImage)
                    .font(.title2)
                    .tint(.blue)
              
                    
            }
            .padding()
        }
        .padding(.bottom, 20.0)
    }
}

