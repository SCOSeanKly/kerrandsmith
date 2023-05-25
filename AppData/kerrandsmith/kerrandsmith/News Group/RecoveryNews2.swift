//
//  RecoveryNews2.swift
//  kerrandsmith
//
//  Created by Sean Kelly on 17/05/2023.
//

import SwiftUI

struct RecoveryNews2: View {
    
    @State private var newsItem: NewsItem? = nil
    @State private var rectangleColor: Color = .blue
    
    var body: some View {
        
        newsInsertView(titleText: newsItem?.title ?? "", subTitleText: newsItem?.body ?? "", lineLimit: 5, showCallUs: true, showWebLink: false, webLink: "", systemImage: "phone", linkText: "Call Us", linkColour: Color.green)
            .onAppear {
                fetchRecoveryNews2()
            }
    }
    
    func fetchRecoveryNews2() {
        guard let url = URL(string: "https://raw.githubusercontent.com/SCOSeanKly/kerrandsmith/main/JSON/news/recoveryNews/recoveryNews2.json") else {
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

struct RecoveryNews2_Previews: PreviewProvider {
    static var previews: some View {
        RecoveryNews2()
    }
}

