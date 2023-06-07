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
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.gray, lineWidth: 0.5)
                        .frame(width: imageWidth, height: imageHeight, alignment: .center)
                    
                    ProgressView()
                }
            case .success(let loadedImage):
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.gray, lineWidth: 0.5)
                        .frame(width: imageWidth, height: imageHeight, alignment: .center)
                    
                    loadedImage
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipped()
                        .cornerRadius(5)
                       
                    LargeImageViewButton(systemImage: "square.and.arrow.down.fill", imageWidth: imageWidth, imageHeight: imageHeight, tintColour: Color.white)
                        .disabled(true)
                }
                .offset(x: offset)
            case .failure:
                
                ZStack {
                    HStack {
                        Spacer()
                        VStack(alignment: .center) {
                            Image(systemName: "exclamationmark.triangle")
                                .foregroundColor(.red)
                            Text("Image Coming Soon")
                                .font(.footnote)
                        }
                        Spacer()
                    }
                    .frame(width: imageWidth, height: imageHeight, alignment: .center)
                    .padding(.bottom, 5.0)
                    
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.gray, lineWidth: 0.5)
                        .frame(width: imageWidth, height: imageHeight, alignment: .center)
                }
                .offset(x: offset)

                
            @unknown default:
                EmptyView()
            }
        }
        .padding()
        Spacer()
    }
}



