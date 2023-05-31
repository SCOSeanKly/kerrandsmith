//
//  SocialMediaView.swift
//  kerrandsmith
//
//  Created by Sean Kelly on 25/05/2023.
//

import SwiftUI

struct SocialMediaView: View {
 
    
    var body: some View {
        HStack(spacing: 20) {
            ForEach(socialMediaLogos, id: \.name) { logo in
                Link(destination: logo.url) {
                    Image(logo.name)
                        .resizable()
                        .frame(width: 24, height: 24)
                       
                }
            }
        }
    }
}

struct SocialMediaView_Previews: PreviewProvider {
    static var previews: some View {
        SocialMediaView()
    }
}

