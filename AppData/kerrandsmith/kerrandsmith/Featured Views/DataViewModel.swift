//
//  DataViewModelCars.swift
//  kerrandsmith
//
//  Created by Sean Kelly on 16/05/2023.
//

import SwiftUI

class DataViewModel: ObservableObject {
    @Published var images: [ImageModel] = []
    
    func loadImages(fromURLString urlString: String, baseURLString: String) {
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
                let json = try JSONSerialization.jsonObject(with: data, options: [])

                if let dict = json as? [String: Any],
                   let imageArray = dict["images"] as? [[String: Any]] {
                    DispatchQueue.main.async {
                        self.images = imageArray.compactMap { imageDict in
                            guard let imageName = imageDict["imageName"] as? String,
                                  let title = imageDict["title"] as? String,
                                  let subtitle = imageDict["subtitle"] as? String else {
                                return nil
                            }

                            let price = imageDict["price"] as? String ?? "" // Default value for price
                            let image_1 = imageDict["image1"] as? String ?? "" // Default value for image1
                            let image_2 = imageDict["image2"] as? String ?? "" // Default value for image2
                            let image_3 = imageDict["image3"] as? String ?? "" // Default value for image3
                            let image_4 = imageDict["image4"] as? String ?? "" // Default value for image4
                            let image_5 = imageDict["image5"] as? String ?? "" // Default value for image5

                            let imageUrlLowRes = baseURLString + imageName
                            let image1 = baseURLString + image_1
                            let image2 = baseURLString + image_2
                            let image3 = baseURLString + image_3
                            let image4 = baseURLString + image_4
                            let image5 = baseURLString + image_5

                            return ImageModel(imageUrlLowRes: imageUrlLowRes, title: title, subtitle: subtitle, price: price, image1: image1, image2: image2, image3: image3, image4: image4, image5: image5)
                        }
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}


struct ImageModel: Identifiable {
    let id = UUID()
    let imageUrlLowRes: String
    let title: String
    let subtitle: String
    let price: String
    let image1: String
    let image2: String
    let image3: String
    let image4: String
    let image5: String
}
