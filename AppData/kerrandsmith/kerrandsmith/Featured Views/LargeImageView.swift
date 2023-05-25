//
//  LargeImageView.swift
//  kerrandsmith
//
//  Created by Sean Kelly on 24/05/2023.
//

import SwiftUI

struct LargeImageView: View {
    let imageURL: String
    let imageWidth = UIScreen.main.bounds.width * 0.962
    let imageHeight = UIScreen.main.bounds.width * 0.67
    let offset = UIScreen.main.bounds.width * 0.01
    
    var body: some View {
        AsyncImage(url: URL(string: imageURL)) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let loadedImage):
                ZStack {
                    
                    loadedImage
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipped()
                        .cornerRadius(5)
                        .offset(x: offset)
                    
                    LargeImageViewButton(systemImage: "square.and.arrow.down.fill", imageWidth: imageWidth, imageHeight: imageHeight, tintColour: Color.white)
                        .disabled(true)
                }
            case .failure:
                
                VStack {
                    Image(systemName: "exclamationmark.triangle")
                        .foregroundColor(.red)
                    Text("Image Coming Soon")
                        .font(.footnote)
                }
            @unknown default:
                EmptyView()
            }
        }
        .padding()
        Spacer()
    }
}

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

