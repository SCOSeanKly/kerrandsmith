//
//  HeaderImageSize.swift
//  kerrandsmith
//
//  Created by Sean Kelly on 18/05/2023.
//

import SwiftUI

extension View {
    func customFrame(width: CGFloat = UIScreen.main.bounds.width, height: CGFloat = UIScreen.main.bounds.width * 0.8) -> some View {
        self.frame(width: width, height: height)
    }
}



