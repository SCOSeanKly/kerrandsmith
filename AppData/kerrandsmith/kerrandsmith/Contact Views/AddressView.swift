//
//  AddressView.swift
//  kerrandsmith
//
//  Created by Sean Kelly on 15/05/2023.
//

import SwiftUI

struct AddressView: View {
    var body: some View {
        
        HStack {
            Text("Riverside Garage, Ayr Road, Cumnock, KA18 1BJ")
                .font(.subheadline)
                .fontWeight(.bold)
            Spacer()
        }
        .padding(.horizontal)
        HStack {
            Text("Tel: 01290 422440")
                .font(.subheadline)
            Spacer()
        }
        .padding([.leading, .trailing])
        .padding(.top, 1)
       
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView()
    }
}
