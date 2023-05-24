//
//  ContactRecoveryView.swift
//  kerrandsmith
//
//  Created by Sean Kelly on 17/05/2023.
//

import SwiftUI

struct ContactRecoveryView: View {
    
    let phoneNumber = "01290428800"
    let buttonWidth = UIScreen.main.bounds.width * 0.8
    
    var body: some View {
        HStack{
            
            Button(action: {
                if let url = URL(string: "tel:\(phoneNumber)") {
                    UIApplication.shared.open(url)
                }
            }) {
                Text("\(Image(systemName: "phone")) Call Recovery")
                    .foregroundColor(.white)
                    .frame(maxWidth: buttonWidth)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(6)
                    .minimumScaleFactor(0.5)
            }
            
        }
        .padding()
    }
}

struct ContactRecoveryView_Previews: PreviewProvider {
    static var previews: some View {
        ContactRecoveryView()
    }
}
