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
    let screenHeight = UIScreen.main.bounds.height
    let imageHeight = UIScreen.main.bounds.width * 0.8
    @Binding var forceRefresh: Bool
    
    
    var body: some View {
        
            VStack {
             
                if screenHeight == 932 || screenHeight == 852 { // check for iP14PM or iP14
                    CustomRefreshView(showsIndicator: false) {
                        
                        HeaderLogoView()
                        
                        ScrollingHeaderViewImages()
                        
                        FeaturedView(forceRefresh: $forceRefresh)
                        
                    } onRefresh: {
                        forceRefresh.toggle()
                    }
                } else {
                    
                    ScrollView(showsIndicators: false) {
                        HeaderLogoView()
                        
                        ScrollingHeaderViewImages()
                        
                        FeaturedView(forceRefresh: $forceRefresh)
                    }
                }
               
                Spacer()
                
            }
            .ignoresSafeArea()
            .prefersPersistentSystemOverlaysHidden()
    }
}

struct ScrollingHeader_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .preferredColorScheme(.light)
            .environment(\.colorScheme, .light) // or .light
            .environment(\.sizeCategory, .small)
    }
}


