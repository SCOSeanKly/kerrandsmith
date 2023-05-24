//
//  ScrollingHeaderView.swift
//  kerrandsmith
//
//  Created by Sean Kelly on 19/05/2023.
//

import SwiftUI

struct ScrollingHeaderViewImages: View {
    @ObservedObject var viewModelHeader = DataViewModelHeader()
    let screenWidth = UIScreen.main.bounds.width
    @State private var currentIndex = 0
    private let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()

    var body: some View {
        
        ZStack {
            VStack {
                
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(height: 60)
                
                if !viewModelHeader.images.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 0) {
                            ForEach(viewModelHeader.images.indices, id: \.self) { index in
                                URLImageViewHeader(image: viewModelHeader.images[index])
                                    .scaledToFill()
                                    .customFrame()
                                    .clipped()
                                
                            }
                        }
                        .animation(.easeInOut(duration: 1.0), value: currentIndex)
                        .offset(x: CGFloat(currentIndex) * -screenWidth, y: 0)
                        .onReceive(timer) { _ in
                            currentIndex = (currentIndex + 1) % viewModelHeader.images.count
                        }
                        .disabled(true)
                    }
                    
                    HStack {
                        ForEach(Array(0..<viewModelHeader.images.count), id: \.self) { index in
                            Circle()
                                .frame(width: 6, height: 6)
                                .foregroundColor(index == currentIndex ? .red : .gray)
                        }
                    }
                    .padding(.top, -28)
                    
                    
                    
                    
                } else {
                    Text("Loading images...")
                }
            }
            .disabled(true)
        }
        .onAppear {
            viewModelHeader.loadImages()
        }
    }
}



struct URLImageViewHeader: View {
    let image: ImageModelHeader

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: image.image)) { phase in
                switch phase {
                case .empty:
                    ZStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .customFrame()
                        ProgressView()
                    }
                case .success(let loadedImage):
                    loadedImage
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                case .failure:
                    ZStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .customFrame()
                        Image(systemName: "xmark.circle")
                    }
                @unknown default:
                    EmptyView()
                }
            }
            .customFrame()
            .cornerRadius(5)
        }
    }
}

struct ImageModelHeader {
    let image: String
}

class DataViewModelHeader: ObservableObject {
    @Published var images: [ImageModelHeader] = []

    func loadImages() {
        let baseUrlString = "https://raw.githubusercontent.com/SCOSeanKly/kerrandsmith/main/FeaturedImages/Cars/"
        let urlString = "https://raw.githubusercontent.com/SCOSeanKly/kerrandsmith/main/JSON/featuredHeaderImages.json"

        guard let url = URL(string: urlString) else {
            return
        }

        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 10
        config.timeoutIntervalForResource = 10

        let session = URLSession(configuration: config)

        session.dataTask(with: url) { data, response, error in
            guard let data = data else {
                return
            }

            do {
                let imageNames = try JSONDecoder().decode([String].self, from: data)
                DispatchQueue.main.async {
                    self.images = imageNames.indices.map { index in
                        let imageName = imageNames[index]
                        let imageUrlString = baseUrlString + imageName
                        let image = ImageModelHeader(image: imageUrlString)
                        return image
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}


struct ScrollingHeaderViewImages_Previews: PreviewProvider {
    static var previews: some View {
        ScrollingHeaderViewImages()
    }
}

