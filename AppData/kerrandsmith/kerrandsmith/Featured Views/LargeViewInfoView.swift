//
//  LargeViewInfoView.swift
//  kerrandsmith
//
//  Created by Sean Kelly on 18/05/2023.
//

import SwiftUI
import UIKit

struct LargeViewInfoView: View {
    
    let screenWidth = UIScreen.main.bounds.width
    @State private var showContactFormView: Bool = false
    @State private var rectangleColor: Color = .blue
    
    var body: some View {
        ZStack {
            
            VStack {
                HStack {
                    Text("Want to see more?")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                    
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.bottom, 5)
                
                HStack {
                    Text("Seeing is believing when it comes to our exceptional selection of cars, vans, and trailers. Don't just take our word for it – make an appointment or give us a call to arrange a personal viewing.")
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

struct LargeViewInfoView_Previews: PreviewProvider {
    static var previews: some View {
        LargeViewInfoView()
    }
}

