//
//  Openinghours.swift
//  kerrandsmith
//
//  Created by Sean Kelly on 25/05/2023.
//

import SwiftUI

struct OpeningHours: View {
    
    let frameWidth: CGFloat = 65
    @State private var rectangleColor: Color = .blue
    var body: some View {
      
        VStack(alignment: .leading) {
            HStack {
                Text("Opening Hours")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                
                Spacer()
            }
            .padding(.bottom, 5)
            
            HStack {
                HStack {
                    Text("Mon - Fri")
                        .font(.footnote)
                        .opacity(0.8)
                    
                    Spacer()
                }
                    .frame(width: frameWidth)
                   
                Text("08:00 - 17:30")
                    .font(.footnote)
                    .multilineTextAlignment(.leading)
                    .opacity(0.8)
                
                Spacer()
            }
            
            HStack {
                HStack {
                    Text("Saturday")
                        .font(.footnote)
                        .opacity(0.8)
                    
                    Spacer()
                }
                    .frame(width: frameWidth)
                
                Text("08:00 - 13:00")
                    .font(.footnote)
                    .multilineTextAlignment(.leading)
                    .opacity(0.8)
                
                Spacer()
            }
            
            HStack {
                HStack {
                    Text("Sunday")
                        .font(.footnote)
                        .opacity(0.8)
                    
                    Spacer()
                }
                    .frame(width: frameWidth)
                
                Text("Closed")
                    .font(.footnote)
                    .multilineTextAlignment(.leading)
                    .opacity(0.8)
                
                Spacer()
            }
            
          OpenOrClosedView()
                .padding(.top, 1)
        }
        .padding()
        .background(rectangleColor.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 5))
        .padding(.horizontal, 5)
        .onAppear {
                generateRandomColor()
            }
    }
    
    func generateRandomColor() {
        let colors: [Color] = [
            .cyan, .orange, .teal, .indigo, .brown, .red,
            .green, .blue, .yellow, .pink, .purple,
            .primary, .secondary
        ]
        rectangleColor = colors.randomElement() ?? .blue
    }
}

struct OpeningHours_Previews: PreviewProvider {
    static var previews: some View {
        OpeningHours()
    }
}
