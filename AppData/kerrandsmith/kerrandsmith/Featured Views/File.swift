//
//  File.swift
//  kerrandsmith
//
//  Created by Sean Kelly on 19/05/2023.
//

import Foundation

struct ImageModel: Identifiable {
    let id = UUID()
    let imageUrlLowRes: String
    let title: String
    let subtitle: String
    let image1: String
    let image2: String
    let image3: String
    let image4: String
    let image5: String
}
