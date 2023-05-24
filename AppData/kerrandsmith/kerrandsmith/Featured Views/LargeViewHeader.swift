//
//  LargeViewHeader.swift
//  kerrandsmith
//
//  Created by Sean Kelly on 19/05/2023.
//

import SwiftUI

struct LargeViewHeader: View {
    @State private var rectangleColor: Color = .blue
    @Binding var showContactFormView: Bool
    
    
    let titleString: String
    let subtitleString: String
    
    var body: some View {
        ZStack {
            
            VStack {
                HStack {
                    Text(titleString)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                    
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.bottom, 5)
                
                HStack {
                    Text(subtitleString)
                        .font(.footnote)
                        .lineLimit(10)
                        .multilineTextAlignment(.leading)
                        .opacity(0.8)
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        if let url = URL(string: "tel:\(01290422440)") {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        Text("\(Image(systemName: "phone")) Call Us")
                            .font(.caption)
                            .foregroundColor(.green)
                            .fontWeight(.semibold)
                            .padding(.top, 5)
                    }
                }
                .padding(.trailing)
                
            }
            .padding()
            .background(rectangleColor.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .padding(.horizontal, 5)
            .padding(.top)
            
        }
        .onAppear {
            generateRandomColor()
        }
    }
    
    func generateRandomColor() {
        let colors: [Color] = [.red, .green, .cyan, .orange, .yellow, .teal, .indigo, .brown, .mint]
        rectangleColor = colors.randomElement() ?? .blue
    }
    
}


