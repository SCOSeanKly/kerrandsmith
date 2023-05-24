//
//  HeaderLogoView.swift
//  kerrandsmith
//
//  Created by Sean Kelly on 15/05/2023.
//

import SwiftUI

struct HeaderLogoView: View {
    let webAddresses = [
        "Kerr & Smith ": "https://www.kerrandsmith.co.uk",
        "Vauxhall": "https://www.vauxhall.co.uk",
        "SsangYong": "https://www.ssangyonggb.co.uk",
        "Brian James Trailers": "https://www.brianjamestrailers.co.uk/en/"
    ]
    
    let screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
       
         
            VStack {
                
                VStack {
                    
                        HStack {
                            VStack {
                                Image("logo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 130, height: 60)
                                    .padding()
                                    .offset(y: 10)
                            }
                            
                            Spacer()
                            
                            Menu {
                                Section(header: Text("Useful Websites")) {
                                    ForEach(webAddresses.keys.sorted(), id: \.self) { name in
                                        Button(action: {
                                            if let address = webAddresses[name] {
                                                openWebAddress(address)
                                            }
                                        }) {
                                            Text(name)
                                        }
                                    }
                                }
                            } label: {
                                Image(systemName: "globe")
                                    .font(.title)
                                    .padding()
                            }
                            
                        }
                        .background(.ultraThinMaterial)
                    
                    
                    Spacer()
                }
                .frame(height: 60)
                
                Spacer()
                
            }
        
    }
    
    func openWebAddress(_ address: String) {
        // Open the web address
        if let url = URL(string: address) {
            UIApplication.shared.open(url)
        }
    }
}


struct HeaderLogoView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderLogoView()
    }
}
