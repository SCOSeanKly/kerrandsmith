//
//  NewsContent.swift
//  kerrandsmith
//
//  Created by Sean Kelly on 17/05/2023.
//

import SwiftUI

struct NewsItem: Decodable {
    let title: String
    let body: String
}

struct FeaturedNews: View {
    
    @State private var showContactFormView: Bool = false
    @State private var newsItem: NewsItem? = nil
    
    var body: some View {
        
        newsInsertView(titleText: newsItem?.title ?? "", subTitleText: newsItem?.body ?? "", lineLimit: 5, showCallUs: true, showWebLink: false, webLink: "", systemImage: "phone", linkText: "Arrange a test drive", linkColour: Color.green)
            .onAppear {
                fetchNews()
            }
    }
    
    func fetchNews() {
        guard let url = URL(string: "https://raw.githubusercontent.com/SCOSeanKly/kerrandsmith/main/JSON/featuredNews.json") else {
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

struct FeaturedNews_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedNews()
    }
}
