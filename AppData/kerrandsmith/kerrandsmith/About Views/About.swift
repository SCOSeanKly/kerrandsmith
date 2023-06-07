//
//  About.swift
//  kerrandsmith
//
//  Created by Sean Kelly on 15/05/2023.
//

import SwiftUI

struct About: View {
    @Binding var showBookingForm: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text("ABOUT US")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding()
            
            ScrollView(showsIndicators: false) {
                
             //   HeaderImageView()
                
                MapImageView()
                
                AddressView()
                
                Divider()
                    .padding(.horizontal)
                
                HStack {
                    Text("Discover Ayrshire's premier dealership....")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                    
                    Spacer()
                    
                }
                    .padding(.horizontal)
                    .padding(.top)
                
                ForEach(aboutBlock.indices, id: \.self) { index in
                    AboutBlockView(text: aboutBlock[index])
                    
                    if index == 0 {
                        AboutNews(lineLimit: 4, showBookingForm: $showBookingForm)
                            .padding(.top)
                    }
                }
                
                HStack {
                    Text("If you require any more information, please contact us.")
                        .font(.footnote)
                        .padding(.horizontal)
                        .padding(.bottom, 3)
                        .padding(.top)
                    
                   Spacer()
                }
               
                Group {
                    OpeningHours()
                    
                    CallUsButton(phoneNumber: "01290422440", buttonText: "Call Us")
                        .padding(.bottom)
                    
                    SocialMediaView()
                    
                    AboutCopyrightView()
                        .padding(.bottom, 50)
                }
                
                Spacer()
                
            }
        }
    }
}

struct HeaderImageView: View {
    let screenWidth = UIScreen.main.bounds.width
    let imageHeight = UIScreen.main.bounds.width * 0.8
    
    var body: some View {
        Image("image2")
            .resizable()
            .scaledToFill()
            .customFrame()
            .clipped()
    }
}

struct AboutBlockView: View {
    let text: String
    
    var body: some View {
        HStack {
            Text(text)
                .font(.footnote)
                .padding(.horizontal)
            
            Spacer()
        }
        .padding(.top)

    }
}
