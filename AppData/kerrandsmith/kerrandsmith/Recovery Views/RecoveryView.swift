//
//  RecoveryView.swift
//  kerrandsmith
//
//  Created by Sean Kelly on 15/05/2023.
//

import SwiftUI

struct RecoveryView: View {
    
    @State private var currentIndex = 0
    private let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    
    let screenWidth = UIScreen.main.bounds.width
    let imageCount = recoveryImages.count
    let imageHeight = UIScreen.main.bounds.width * 0.8
    
    
    var body: some View {
        VStack {
            HStack {
                Text("RECOVERY")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding()
            ScrollView (showsIndicators: false){
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        ForEach(0..<imageCount, id: \.self) { index in
                            Image(recoveryImages[index])
                                .resizable()
                                .scaledToFill()
                                .customFrame()
                                .clipped()
                        }
                    }
                    .animation(.easeInOut(duration: 1.0), value: currentIndex)
                    .offset(x: CGFloat(currentIndex) * -screenWidth, y: 0)
                    .onReceive(timer) { _ in
                        currentIndex = (currentIndex + 1) % imageCount
                    }
                }
                .disabled(true)
                
                HStack(spacing: 8) {
                    ForEach(0..<imageCount, id: \.self) { index in
                        Circle()
                            .frame(width: 5, height: 5)
                            .foregroundColor(currentIndex == index ? .white : .gray)
                    }
                }
                .padding(.top, -28)
                
                    RecoveryLogosView()
                        .padding(.bottom)
                    
                    RecoveryTextView()
                }
                
                Spacer()
                
            }
        }
    }
    
}

struct RecoveryView_Previews: PreviewProvider {
    static var previews: some View {
        RecoveryView()
            .preferredColorScheme(.light)
            .environment(\.colorScheme, .light) // or .light
            .environment(\.sizeCategory, .small)
    }
}
