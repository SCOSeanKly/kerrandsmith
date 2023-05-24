//
//  RequiredFieldModifier.swift
//  kerrandsmith
//
//  Created by Sean Kelly on 18/05/2023.
//

import SwiftUI

struct RequiredFieldModifier: ViewModifier {
    let fieldValue: String
    let showValidation: Bool
    
    func body(content: Content) -> some View {
        let isInvalid = showValidation && fieldValue.isEmpty
        
        return content
            .padding(7) // Add padding to increase the size of the stroke
            .overlay(
                RoundedRectangle(cornerRadius: 7)
                    .stroke(isInvalid ? Color.red : Color.clear, lineWidth: 0.5)
            )
            .overlay(
                Group {
                    if isInvalid {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(.red)
                            .padding(.trailing, 8)
                    }
                },
                alignment: .trailing
            )
    }
}



