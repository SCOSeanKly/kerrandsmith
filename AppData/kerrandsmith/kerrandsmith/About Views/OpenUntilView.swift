//
//  OpenUntilView.swift
//  kerrandsmith
//
//  Created by Sean Kelly on 25/05/2023.
//

import SwiftUI

struct OpenUntilView: View {
    let today = Calendar.current.component(.weekday, from: Date())
    let closingTime: String

    init() {
        switch today {
        case 1: // Sunday
            closingTime = "We are Closed Today"
        case 7: // Saturday
            closingTime = "Open Until 13:00 Today"
        default: // Monday to Friday
            closingTime = "Open Until 17:30 Today"
        }
    }

    var body: some View {
        HStack {
            Text(closingTime)
                .font(.subheadline)
            
            Spacer()
        }
    }
}



struct OpenUntilView_Previews: PreviewProvider {
    static var previews: some View {
        OpenUntilView()
    }
}
