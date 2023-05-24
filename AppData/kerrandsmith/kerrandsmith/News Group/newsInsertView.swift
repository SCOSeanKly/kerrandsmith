//
//  FeaturedFooterView.swift
//  kerrandsmith
//
//  Created by Sean Kelly on 18/05/2023.
//

import SwiftUI
import UIKit

struct newsInsertView: View {
    
    let screenWidth = UIScreen.main.bounds.width
    @State private var showContactFormView: Bool = false
    @State private var rectangleColor: Color = .blue
    let titleText: String
    let subTitleText: String
    let lineLimit: Int
    let showCallUs: Bool
    let showWebLink: Bool
    let webLink: String
    let systemImage: String
    let linkText: String
    let linkColour: Color
    
    var body: some View {
        ZStack {
            
            VStack {
                HStack {
                    Text(titleText)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                    
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.bottom, 5)
                
                HStack {
                    Text(subTitleText)
                        .font(.footnote)
                        .lineLimit(5)
                        .multilineTextAlignment(.leading)
                        .opacity(0.8)
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                
                if showCallUs {
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            if let url = URL(string: "tel:\(01290422440)") {
                                UIApplication.shared.open(url)
                            }
                        }) {
                            Text("\(Image(systemName: "phone")) \(linkText)")
                                .font(.caption)
                                .foregroundColor(linkColour)
                                .fontWeight(.semibold)
                                .padding(.top, 5)
                        }
                    }
                    .padding(.trailing)
                } else if showWebLink {
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            openWebAddress(webLink)
                            }
                        ) {
                            Text("\(Image(systemName: systemImage)) \(linkText)")
                                .font(.caption)
                                .foregroundColor(linkColour)
                                .fontWeight(.semibold)
                                .padding(.top, 5)
                        }
                    }
                    .padding(.trailing)
                }
            }
            .padding()
            .background(rectangleColor.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .padding(.horizontal, 5)
        }
        .onAppear {
            generateRandomColor()
        }
    }
    
    func openWebAddress(_ address: String) {
        // Open the web address
        if let url = URL(string: address) {
            UIApplication.shared.open(url)
        }
    }
    
    func generateRandomColor() {
        let colors: [Color] = [
            .cyan,
            .orange,
            .teal,
            .indigo,
            .brown,
            .red,
            .green,
            .blue,
            .yellow,
            .pink,
            .purple,
            .primary,
            .secondary
        ]

        rectangleColor = colors.randomElement() ?? .blue
    }
}

