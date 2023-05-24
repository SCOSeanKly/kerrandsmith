//
//  ServicesNews2.swift
//  kerrandsmith
//
//  Created by Sean Kelly on 22/05/2023.
//

import SwiftUI

struct ServicesNews2: View {
    
    @State private var showContactFormView: Bool = false
    @State private var newsItem: NewsItem? = nil
    
    var body: some View {
        
        newsInsertView(titleText: newsItem?.title ?? "", subTitleText: newsItem?.body ?? "", lineLimit: 5, showCallUs: true, showWebLink: false, webLink: "https://www.kerrandsmithvauxhall.co.uk/service/", systemImage: "phone", linkText: "Call Us", linkColour: Color.accentColor)
            .onAppear {
                fetchNews()
            }
    }
    
    func fetchNews() {
        guard let url = URL(string: "https://raw.githubusercontent.com/SCOSeanKly/kerrandsmith/main/JSON/serviceNews2.json") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if let data = data {
                do {
                    let newsData = try JSONDecoder().decode(NewsItem.self, from: data)
                    DispatchQueue.main.async {
                        newsItem = newsData
                    }
                } catch {
                    print("Error decoding JSON: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
}

struct ServicesNews2_Previews: PreviewProvider {
    static var previews: some View {
        ServicesNews2()
    }
}
