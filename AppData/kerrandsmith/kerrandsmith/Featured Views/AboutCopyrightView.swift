//
//  AboutCopyrightView.swift
//  kerrandsmith
//
//  Created by Sean Kelly on 06/06/2023.
//

import SwiftUI

struct AboutCopyrightView: View {
    
    let frameWidth = UIScreen.main.bounds.width * 0.8
    
    var currentYear: String {
        let year = Calendar.current.component(.year, from: Date())
        return "\(year)"
    }
    
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
                Text("© Kerr & Smith Cumnock Ltd \(currentYear)")
                    .font(.caption2)
                    .lineLimit(3)
                    .multilineTextAlignment(.center)
                    .opacity(0.4)
                    .scaleEffect(0.8)
                
            }
            .padding(.horizontal)
        }
        .frame(width: frameWidth)
    }
}

struct AboutCopyrightView_Previews: PreviewProvider {
    static var previews: some View {
        AboutCopyrightView()
    }
}

