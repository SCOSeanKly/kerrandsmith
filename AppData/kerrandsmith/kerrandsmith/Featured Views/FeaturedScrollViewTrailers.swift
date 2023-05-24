//
//  FeaturedScrollViewTrailers.swift
//  kerrandsmith
//
//  Created by Sean Kelly on 16/05/2023.
//


import SwiftUI
import SwiftUIMailView

struct FeaturedScrollViewTrailers: View {
    @ObservedObject var viewModel = DataViewModel()
    
    let urlString = "https://raw.githubusercontent.com/SCOSeanKly/kerrandsmith/main/JSON/featured/featuredTrailers.json"
    let baseURLString = "https://raw.githubusercontent.com/SCOSeanKly/kerrandsmith/main/FeaturedImages/Trailers/"
    
    var body: some View {
        VStack {
            if !viewModel.images.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(viewModel.images) { image in
                            URLImageViewTrailers(image: image)
                                .cornerRadius(5)
                                .padding(.horizontal, 5)
                        }
                    }
                }
            } else {
                Text("Loading images...")
            }
        }
        .onAppear {
            viewModel.loadImages(fromURLString: urlString, baseURLString: baseURLString)
        }
    }
}

struct URLImageViewTrailers: View {
    let image: ImageModel
    @State private var showContactFormView: Bool = false
    @State private var showLargeImage: Bool = false
    let thumbWidth: CGFloat = 4.4
    @State private var rectangleColor: Color = .blue
    
    @State private var showMailView = false
    @State private var mailData: ComposeMailData
    
    init(image: ImageModel) {
        self.image = image
        _mailData = State(initialValue: ComposeMailData(subject: "Enquiry Type: [Trailers] with Kerr & Smith Cumnock",
                                                       recipients: ["ske@kerrandsmith.co.uk"],
                                                        message: """
                                                        \(image.title)\n\(image.subtitle)
                                                        
                                                        Enquiry:
                                                        """,
                                                       attachments: []))}
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: image.imageUrlLowRes)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let loadedImage):
                    
                    ZStack {
                        loadedImage
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                        
                        Button {
                            showLargeImage = true
                        }label: {
                            LargeViewButton(systemImage: "camera.fill")
                        }
                        
                    }
                case .failure:
                    Image(systemName: "exclamationmark.triangle")
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 280, height: 200)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.gray, lineWidth: 0.5)
            )
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .sheet(isPresented: $showLargeImage) {
                RoundedRectangle(cornerRadius: 3)
                    .frame(width: 40, height: 6)
                    .foregroundColor(Color.gray.opacity(0.5))
                    .padding(.top, 8)
                ScrollView {
                    LargeViewHeader(showContactFormView: $showContactFormView, titleString: image.title, subtitleString: image.subtitle)
                    LargeImageView(imageURL: image.image1)
                    LargeImageView(imageURL: image.image2)
                    LargeViewInfoView()
                    LargeImageView(imageURL: image.image3)
                    LargeImageView(imageURL: image.image4)
                    CopyrightView()
                }
                .prefersPersistentSystemOverlaysHidden()
            }
            
            VStack {
                HStack {
                    Text(image.title)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Spacer()
                }
                HStack {
                    Text(image.subtitle)
                        .font(.footnote)
                        .opacity(0.8)
                        .lineLimit(1)
                    Spacer()
                }
                HStack {
                  
                    Text(image.price)
                        .font(.footnote)
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
                            //ContactMapView()
                            MailView(data: $mailData) { result in
                                print(result)}
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
                            //ContactMapView()
                            MailView(data: $mailData) { result in
                                print(result)}
                            
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
}



struct FeaturedScrollViewTrailers_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedScrollViewTrailers()
    }
}

