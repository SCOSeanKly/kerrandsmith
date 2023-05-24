//
//  ContactAboutView.swift
//  kerrandsmith
//
//  Created by Sean Kelly on 17/05/2023.
//

import SwiftUI

struct CallUsButton: View {
    
    let phoneNumber: String
    let buttonWidth = UIScreen.main.bounds.width * 0.8
    let buttonText: String
    
    var body: some View {
        HStack (alignment: .center){
           
            Button(action: {
                if let url = URL(string: "tel:\(phoneNumber)") {
                    UIApplication.shared.open(url)
                }
            }) {
                Text("\(Image(systemName: "phone")) \(buttonText)")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(6)
            }

        }
        .padding(.top)
        .frame(width: buttonWidth)
    }
}

