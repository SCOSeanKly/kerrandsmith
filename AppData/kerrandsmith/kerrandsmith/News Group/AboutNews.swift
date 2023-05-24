//
//  AboutNews2.swift
//  kerrandsmith
//
//  Created by Sean Kelly on 17/05/2023.
//

import SwiftUI

struct AboutNews: View {
    
    @State private var newsItem: NewsItem? = nil
    @State private var rectangleColor: Color = .blue
    
    @State private var isShowingFullText = false
    @State private var isShowingExtraText = false
    
    let screenWidth = UIScreen.main.bounds.width
    let imageVWidth = UIScreen.main.bounds.width * 0.45
    let imageVHeight = UIScreen.main.bounds.width * 0.45
    let imageHWidth = UIScreen.main.bounds.width * 0.9
    let imageHHeight = UIScreen.main.bounds.width * 0.45
    let imageLargeHeight = UIScreen.main.bounds.width * 0.8
    let textHeight = UIScreen.main.bounds.width * 0.3
    let lineLimit: Int
    
    @Binding var showBookingForm: Bool
    
    var body: some View {
      
        VStack {
            HStack {
                Text(newsItem?.title ?? "")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(.bottom, 1)
                
                Spacer()
            }
            HStack {
                Text(newsItem?.body ?? "")
                    .font(.footnote)
                    .opacity(0.8)
                    .lineLimit(isShowingFullText ? nil : (isShowingExtraText ? .max : lineLimit))
                    .fixedSize(horizontal: false, vertical: true)
                
                Spacer()
            }
            if !isShowingFullText && (newsItem?.body.count ?? 0) > lineLimit {
                HStack {
                    
                    Spacer()
                    
                    Button(action: {
                        isShowingExtraText.toggle()
                    }) {
                        Text(isShowingExtraText ? "Show Less" : "Show More")
                            .foregroundColor(.blue)
                            .font(.caption)
                            .padding(.trailing)
                            .padding(.bottom, 2)
                            .padding(.top, 2)
                    }
                }
            }
        }
            .padding()
            .background(rectangleColor.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
            .padding(.horizontal, 5)
            .onAppear {
                fetchAboutNews()
                generateRandomColor()
            }
    }

    
    func fetchAboutNews() {
        guard let url = URL(string: "https://raw.githubusercontent.com/SCOSeanKly/kerrandsmith/main/JSON/aboutNews/news/aboutNews.json") else {
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
    
    func generateRandomColor() {
        let colors: [Color] = [.red, .green, .cyan, .orange, .yellow, .teal, .indigo, .brown, .mint]
        rectangleColor = colors.randomElement() ?? .blue
    }
}
