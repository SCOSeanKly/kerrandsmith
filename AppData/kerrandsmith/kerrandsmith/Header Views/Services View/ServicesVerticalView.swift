//
//  ServicesVerticalView.swift
//  kerrandsmith
//
//  Created by Sean Kelly on 17/05/2023.
//

import SwiftUI
import SwiftUIMailView

struct ServicesVerticalView: View {
    
    let imageName: String
    let imageWidth: CGFloat
    let imageHeight: CGFloat
    let titleText: String
    let subTitleText: String
    let lineLimit: Int
    let showBookingFormButton: Bool
    let bookingFormButtonText: String
    @Binding var showBookingForm: Bool
    let showMore: Bool
    
    
    @State private var isShowingFullText = false
    @State private var isShowingExtraText = false
    
    
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: imageWidth, height: imageHeight)
                .clipped()
                .cornerRadius(5)
            
            VStack {
                HStack {
                    Text(titleText)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding(.bottom, 1)
                    
                    Spacer()
                }
                HStack {
                    Text(subTitleText)
                        .font(.footnote)
                        .opacity(0.8)
                        .lineLimit(isShowingFullText ? nil : (isShowingExtraText ? .max : lineLimit))
                   //     .fixedSize(horizontal: false, vertical: true)
                    
                    Spacer()
                }
                
                HStack {
                    if showBookingFormButton {
                        Button(action: {
                            if !MailView.canSendMail {
                                if let url = URL(string: "tel:\(01290422440)") {
                                    UIApplication.shared.open(url)
                                }
                            } else {
                                showBookingForm = true
                            }
                        }) {
                            Text(!MailView.canSendMail ? "\(Image(systemName: "phone")) Call Us" : "\(Image(systemName: "envelope")) \(bookingFormButtonText)")
                                .foregroundColor(!MailView.canSendMail ? .green : .blue)
                                .font(.caption)
                                .padding(.trailing)
                                .padding(.bottom, 2)
                                .padding(.top, 2)
                        }
                    }
                    
                    Spacer()
                    if showMore {
                        if !isShowingFullText && subTitleText.count > lineLimit {
                            Button(action: {
                                isShowingExtraText.toggle()
                            }) {
                                Text(isShowingExtraText ? "Show Less" : "Show More")
                                    .foregroundColor(.blue)
                                    .font(.caption)
                                    .padding(.trailing)
                                    .padding(.bottom, 2)
                                    .padding(.top, 2)
                            }
                        }
                    }
                }
                .frame(maxWidth: imageWidth, alignment: .bottomTrailing) 
            }
            .padding()
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
       
        }
        .frame(width: imageWidth)
    }
}




