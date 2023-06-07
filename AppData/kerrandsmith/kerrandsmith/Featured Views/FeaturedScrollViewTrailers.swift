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
    
    @Binding var forceRefresh: Bool
    
    var body: some View {
        VStack {
            
            FeaturedHeader(featuredText: "Featured Trailers", systemImage: "arrow.triangle.2.circlepath.camera", text: "\(viewModel.images.count)", forceRefresh: $forceRefresh)
            
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
        .onChange(of: forceRefresh) { newValue in
            if newValue {
                viewModel.loadImages(fromURLString: urlString, baseURLString: baseURLString)
                forceRefresh = false
            }
        }
    }
}

struct URLImageViewTrailers: View {
    let image: ImageModel
    @State private var showContactFormView: Bool = false
    @State private var showLargeImage: Bool = false
    @State private var showMailView = false
    @State private var mailData: ComposeMailData
    let imageWidth = UIScreen.main.bounds.width * 0.65
    let imageHeight = UIScreen.main.bounds.width * 0.45
    @State private var showingAlert = false
    
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
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray, lineWidth: 0.5)
                        
                        ProgressView()
                    }
                case .success(let loadedImage):
                    ZStack {
                        loadedImage
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                        Button {
                            showLargeImage = true
                        } label: {
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
                    VStack (alignment: .center) {
                        LargeViewHeader(showContactFormView: $showContactFormView, titleString: image.title, subtitleString: image.subtitle, priceString: image.price)
                        LargeImageSaveToAlbumswift(image: image, showingAlert: $showingAlert, imageSource: image.image1, imageIndex: 1)
                        LargeImageSaveToAlbumswift(image: image, showingAlert: $showingAlert,imageSource: image.image2, imageIndex: 2)
                        LargeViewInfoView()
                        LargeImageSaveToAlbumswift(image: image, showingAlert: $showingAlert,imageSource: image.image3, imageIndex: 3)
                        LargeImageSaveToAlbumswift(image: image, showingAlert: $showingAlert,imageSource: image.image4, imageIndex: 4)
                        LargeImageSaveToAlbumswift(image: image, showingAlert: $showingAlert, imageSource: image.image4, imageIndex: 5)
                        CopyrightView()
                    }
                }
                .alert("Saved to Photos Album", isPresented: $showingAlert) {
                    Button("OK", role: .cancel) { }
                }
                .prefersPersistentSystemOverlaysHidden()
            }
            
            featuredInfoText(image: image)
            
        }
    }
    func saveImageToPhotoAlbum(_ imageURL: String) {
        guard let url = URL(string: imageURL) else {
            // Handle invalid URL
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                // Handle network error
                print("Error: \(error)")
                return
            }
            
            guard let data = data else {
                // Handle missing data
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                } else {
                    // Handle failed image creation
                }
            }
        }
        
        task.resume()
    }
}



