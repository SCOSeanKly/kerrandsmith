//
//  featuredInfoText.swift
//  kerrandsmith
//
//  Created by Sean Kelly on 24/05/2023.
//

import SwiftUI
import SwiftUIMailView

struct featuredInfoText: View {
    
    let image: ImageModel
    @State private var showContactFormView: Bool = false
    @State private var showLargeImage: Bool = false
    let thumbWidth: CGFloat = 4.4
    @State private var rectangleColor: Color = .blue
    
    @State private var showMailView = false
    @State private var mailData: ComposeMailData
    
    @State private var showingAlert = false
    let imageWidth = UIScreen.main.bounds.width * 0.65
    let imageHeight = UIScreen.main.bounds.width * 0.45
    
    init(image: ImageModel) {
        self.image = image
        _mailData = State(initialValue: ComposeMailData(subject: "Enquiry Type: [Cars] with Kerr & Smith Cumnock",
                                                        recipients: ["ske@kerrandsmith.co.uk"],
                                                        message: """
                                                        \(image.title)\n\(image.subtitle)
                                                        
                                                        Enquiry:
                                                        """,
                                                        attachments: []))}
    
    var body: some View {
        VStack {
            HStack {
                Text(image.title.capitalized)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                               
                Spacer()
            }

            HStack {
                Text(image.subtitle.capitalized)
                    .font(.footnote)
                    .opacity(0.8)
                    .lineLimit(1)
                                
                Spacer()
            }

            HStack {
                Text(image.price.capitalized)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .opacity(0.8)
                    .lineLimit(1)
                    .padding(.top, 5)
                               
                Spacer()
            }

            
            if !MailView.canSendMail {
                HStack {
                    Button(action: {
                        if !MailView.canSendMail {
                            if let url = URL(string: "tel:\(01290422440)") {
                                UIApplication.shared.open(url)
                            }
                        } else {
                            showContactFormView = true
                        }
                    }) {
                        Text(!MailView.canSendMail ? "\(Image(systemName: "phone")) Call Us" : "\(Image(systemName: "envelope")) Enquire")
                            .font(.caption)
                            .foregroundColor(!MailView.canSendMail ? .green : .blue)
                            .fontWeight(.semibold)
                            .padding(.top, 1)
                    }
                    .sheet(isPresented: $showContactFormView) {
                        MailView(data: $mailData) { result in
                            print(result)
                        }
                    }
                    
                    Spacer()
                }
                .disabled(!MailView.canSendMail)
            } else {
                HStack {
                    Button(action: {
                        showContactFormView = true
                    }) {
                        Text("Enquire Now")
                            .font(.caption)
                            .foregroundColor(.blue)
                            .fontWeight(.semibold)
                            .padding(.top, 1)
                    }
                    .sheet(isPresented: $showContactFormView) {
                        MailView(data: $mailData) { result in
                            print(result)
                        }
                    }
                    
                    Spacer()
                }
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
    }
}


