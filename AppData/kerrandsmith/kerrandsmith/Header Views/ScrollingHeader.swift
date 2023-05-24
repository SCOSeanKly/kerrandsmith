//
//  ScrollingHeader.swift
//  kerrandsmith
//
//  Created by Sean Kelly on 15/05/2023.
//

import SwiftUI

struct ScrollingHeader: View {
    @State private var currentIndex = 0
    private let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    
    let screenWidth = UIScreen.main.bounds.width
    let imageHeight = UIScreen.main.bounds.width * 0.8
    
    var body: some View {
        ZStack {
            VStack {
                
                ScrollView (showsIndicators: false) {
                    
                    ScrollingHeaderViewImages()
                      
                    FeaturedView()
                }
                
                Spacer()
            }
            HeaderLogoView()
        }
        .prefersPersistentSystemOverlaysHidden()
    }
}

struct ScrollingHeader_Previews: PreviewProvider {
    static var previews: some View {
        ScrollingHeader()
            .preferredColorScheme(.light)
            .environment(\.colorScheme, .light) // or .light
            .environment(\.sizeCategory, .small)
    }
}


