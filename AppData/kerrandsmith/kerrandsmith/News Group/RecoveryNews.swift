//
//  RecoveryNews.swift
//  kerrandsmith
//
//  Created by Sean Kelly on 17/05/2023.
//

import SwiftUI

struct RecoveryNews: View {
    
    @State private var newsItem: NewsItem? = nil
    
    var body: some View {
        
        newsInsertView(titleText: newsItem?.title ?? "", subTitleText: newsItem?.body ?? "", lineLimit: 5, showCallUs: false, showWebLink: false, webLink: "", systemImage: "phone", linkText: "", linkColour: Color.green)
            .onAppear {
                fetchRecoveryNews()
            }
    }
    
    func fetchRecoveryNews() {
        guard let url = URL(string: "https://raw.githubusercontent.com/SCOSeanKly/kerrandsmith/main/JSON/news/featuredNews/recoveryNews.json") else {
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

struct RecoveryNews_Previews: PreviewProvider {
    static var previews: some View {
        RecoveryNews()
    }
}
