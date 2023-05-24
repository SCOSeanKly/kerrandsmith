//
//  GooButtonView.swift
//  kerrandsmith
//
//  Created by Sean Kelly on 22/05/2023.
//

import SwiftUI

struct GooButtonView: View {
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            GooButton(size: size)
        }
        .preferredColorScheme(.light)
    }
}

struct GooButtonView_Previews: PreviewProvider {
    static var previews: some View {
        GooButtonView()
    }
}
