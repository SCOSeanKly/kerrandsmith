//
//  LargeImageSaveToAlbumswift.swift
//  kerrandsmith
//
//  Created by Sean Kelly on 25/05/2023.
//

import SwiftUI

struct LargeImageSaveToAlbumswift: View {
    
    let image: ImageModel
    @Binding var showingAlert: Bool
    let imageSource: String
    let imageIndex: Int
    
    var body: some View {
        Button {
            saveImageToPhotoAlbum(getImageURL())
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                showingAlert = true
            }
        } label: {
            LargeImageView(imageURL: getImageURL())
        }
    }
    
    func getImageURL() -> String {
        switch imageIndex {
        case 1:
            return image.image1
        case 2:
            return image.image2
        case 3:
            return image.image3
        case 4:
            return image.image4
        case 5:
            return image.image5
        default:
            return "" // Return a default value or handle the case when the image index is out of range.
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
