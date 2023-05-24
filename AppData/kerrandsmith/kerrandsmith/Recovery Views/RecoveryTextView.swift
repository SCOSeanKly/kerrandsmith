//
//  RecoveryTextView.swift
//  kerrandsmith
//
//  Created by Sean Kelly on 17/05/2023.
//

import SwiftUI

struct RecoveryTextView: View {
    var body: some View {
        VStack {
            
            HStack {
                Text("PAS 43 Quality Approved - \nFully trained Recovery Technicians")
                    .font(.headline)
                    .lineLimit(3) // Set the maximum number of lines to 3
                    .multilineTextAlignment(.leading) // Optionally, set the text alignment
                    .padding(.horizontal)
                
                Spacer()
            }
            .padding(.bottom)
            
            HStack {
                Text(recoveryBlock[0])
                    .font(.footnote)
                    .padding(.horizontal)

                
                Spacer()
            }
            .padding(.bottom)
            
            RecoveryNews()
                .padding(.bottom)
            
            HStack {
                Text(recoveryBlock[1])
                    .font(.footnote)
                    .padding(.horizontal)
                
                Spacer()
            }
            .padding(.bottom)
            
           RecoveryNews2()
                .padding(.bottom)
            
            HStack {
                Text(recoveryBlock[2])
                    .font(.footnote)
                    .padding(.horizontal)
                
                Spacer()
            }
            .padding(.bottom)
            
            HStack {
                Text(recoveryBlock[3])
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
                   
                
                Spacer()
            }
  
            CallUsButton(phoneNumber: "01290428800", buttonText: "Call Recovery")
                .padding(.bottom, 50)
            
        }
    }
}

struct RecoveryTextView_Previews: PreviewProvider {
    static var previews: some View {
        RecoveryTextView()
    }
}
