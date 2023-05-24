//
//  ViewBannerImages.swift
//  kerrandsmith
//
//  Created by Sean Kelly on 16/05/2023.
//

import SwiftUI
import SwiftUIMailView

struct FeaturedScrollViewCars: View {
    @ObservedObject var viewModel = DataViewModel()
    
    let urlString = "https://raw.githubusercontent.com/SCOSeanKly/kerrandsmith/main/JSON/featured/featuredCars.json"
    let baseURLString = "https://raw.githubusercontent.com/SCOSeanKly/kerrandsmith/main/FeaturedImages/Cars/"
    
    var body: some View {
        VStack {
            if !viewModel.images.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(viewModel.images) { image in
                            URLImageView(image: image)
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

struct URLImageView: View {
    let image: ImageModel
    @State private var showContactFormView: Bool = false
    @State private var showLargeImage: Bool = false
    let thumbWidth: CGFloat = 4.4
    @State private var rectangleColor: Color = .blue
    
    @State private var showMailView = false
    @State private var mailData: ComposeMailData
    
    @State private var showingAlert = false
    
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
                    
                    Button {
                        saveImageToPhotoAlbum(image.image1)
                        showingAlert.toggle()
                    } label: {
                        LargeImageView(imageURL: image.image1)
                    }
                    
                    Button {
                        saveImageToPhotoAlbum(image.image2)
                        showingAlert.toggle()
                    } label: {
                        LargeImageView(imageURL: image.image2)
                    }
                   
                    LargeViewInfoView()
                    
                    Button {
                        saveImageToPhotoAlbum(image.image3)
                        showingAlert.toggle()
                    } label: {
                        LargeImageView(imageURL: image.image3)
                    }
                
                    Button {
                        saveImageToPhotoAlbum(image.image4)
                        showingAlert.toggle()
                    } label: {
                        LargeImageView(imageURL: image.image4)
                    }
                    
                    CopyrightView()
                }
                .alert("Saved to Photos Album", isPresented: $showingAlert) {
                            Button("OK", role: .cancel) { }
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

struct LargeImageView: View {
    let imageURL: String
    
    
    var body: some View {
        AsyncImage(url: URL(string: imageURL)) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let loadedImage):
                ZStack {
                    loadedImage
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipped()
                        .cornerRadius(5)
                    
                    LargeViewButton(systemImage: "square.and.arrow.down.fill")
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



struct FeaturedScrollViewCars_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedScrollViewCars()
    }
}
