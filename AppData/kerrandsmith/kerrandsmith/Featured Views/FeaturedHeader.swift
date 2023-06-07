//
//  FeaturedHeader.swift
//  kerrandsmith
//
//  Created by Sean Kelly on 16/05/2023.
//

import SwiftUI

struct FeaturedHeader: View {
    @State private var isAnimating = false
    @State private var isShowingNotification = false
    
    let featuredText: String
    let systemImage: String
    let text: String
    @Binding var forceRefresh: Bool
    @State private var rotationAngle: Angle = .degrees(0)
    
    
    var body: some View {
        HStack {
            Text(featuredText)
                .font(.title3)
                .fontWeight(.bold)
            
            Spacer()
          
            HStack {
                
                if isShowingNotification {
                    Image(systemName: "arrow.clockwise.circle")
                        .font(.headline.weight(.light))
                        .foregroundColor(.red.opacity(0.8))
                        .scaleEffect(CGSize(width: 1.4, height: 1.4), anchor: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .rotationEffect(rotationAngle)
                        .animation(.easeInOut(duration: 1.5), value: rotationAngle)
                        .offset(x: -2)
                        .padding(.leading, 4)
                        .onAppear {
                            rotationAngle = .degrees(720)
                        }
                        .onDisappear {
                            rotationAngle = .degrees(0)
                        }

                } else {
                    
                    Image(systemName: systemImage)
                        .font(.headline)
                        .foregroundColor(.gray)
                }
                
                if isShowingNotification {
                    Text("0")
                        .font(.headline)
                        .foregroundColor(.gray)
                } else {
                    Text(text)
                        .font(.headline)
                        .foregroundColor(.gray)
                }
            }
            .scaleEffect(isAnimating ? 0.8 : 1.0)
            .animation(.linear(duration: 0.1), value: isAnimating)
            .padding(.horizontal, 8)
            .padding(.vertical, 6)
            .background(
                RoundedRectangle(cornerRadius: 100)
                    .foregroundColor(.clear)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 100))
            )
            .onTapGesture {
                handleTapGesture()
            }
        }
        .padding(.horizontal)
        .padding(.top)
    }
    
    private func handleTapGesture() {
        isAnimating = true
        
        withAnimation(.linear(duration: 0.2)) {
            isShowingNotification = true
        }
        
        forceRefresh.toggle()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
            withAnimation(.linear(duration: 0.1)) {
                isShowingNotification = false
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            isAnimating = false
        }
    }
}

struct FeaturedHeader_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
        
    }
}


