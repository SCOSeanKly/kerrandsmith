//
//  SwiftUIView.swift
//  kerrandsmith
//
//  Created by Sean Kelly on 19/05/2023.
//

import SwiftUI

struct CopyrightView: View {
    
    let frameWidth = UIScreen.main.bounds.width * 0.8
    
    var body: some View {
               
        VStack(spacing: 1) {
            HStack {
                Text("")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.bottom, 5)
            
            HStack {
                Text("All image rights belong to Kerr and Smith Cumnock Ltd. Unauthorized use or distribution of these images without our permission is strictly prohibited.")
                    .font(.caption2)
                    .lineLimit(3)
                    .multilineTextAlignment(.center)
                    .opacity(0.4)
                    .scaleEffect(0.8)
                
                Spacer()
            }
            .padding(.horizontal)
        }
        .frame(width: frameWidth)
    }
}

struct CopyrightView_Previews: PreviewProvider {
    static var previews: some View {
        CopyrightView()
    }
}
