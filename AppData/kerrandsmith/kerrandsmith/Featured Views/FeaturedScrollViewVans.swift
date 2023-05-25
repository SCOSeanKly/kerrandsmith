//
//  FeaturedScrollViewVans.swift
//  kerrandsmith
//
//  Created by Sean Kelly on 16/05/2023.
//



import SwiftUI
import SwiftUIMailView

struct FeaturedScrollViewVans: View {
    @ObservedObject var viewModel = DataViewModel()
    
    let urlString = "https://raw.githubusercontent.com/SCOSeanKly/kerrandsmith/main/JSON/featured/featuredVans.json"
    let baseURLString = "https://raw.githubusercontent.com/SCOSeanKly/kerrandsmith/main/FeaturedImages/Vans/"
    
    var body: some View {
        VStack {
            if !viewModel.images.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(viewModel.images) { image in
                            URLImageViewVans(image: image)
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

struct URLImageViewVans: View {
    let image: ImageModel
    @State private var showContactFormView: Bool = false
    @State private var showLargeImage: Bool = false
    @State private var showMailView = false
    @State private var mailData: ComposeMailData
    let imageWidth = UIScreen.main.bounds.width * 0.65
    let imageHeight = UIScreen.main.bounds.width * 0.45
    
    init(image: ImageModel) {
        self.image = image
        _mailData = State(initialValue: ComposeMailData(subject: "Enquiry Type: [Vans] with Kerr & Smith Cumnock",
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
                            LargeImageViewButton(systemImage: "camera.fill", imageWidth: imageWidth, imageHeight: imageHeight, tintColour: Color.white)
                        }
                        
                    }
                case .failure:
                    Image(systemName: "exclamationmark.triangle")
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: imageWidth, height: imageHeight)
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
                    LargeViewHeader(showContactFormView: $showContactFormView, titleString: image.title, subtitleString: image.subtitle, priceString: image.price)
                    LargeImageView(imageURL: image.image1)
                    LargeImageView(imageURL: image.image2)
                    LargeViewInfoView()
                    LargeImageView(imageURL: image.image3)
                    LargeImageView(imageURL: image.image4)
                    CopyrightView()
                }
                .prefersPersistentSystemOverlaysHidden()
            }
            
            featuredInfoText(image: image)
            
        }
    }
}



struct FeaturedScrollViewVans_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedScrollViewVans()
    }
}
