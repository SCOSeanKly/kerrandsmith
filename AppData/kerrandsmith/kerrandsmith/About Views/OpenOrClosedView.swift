//
//  OpenOrClosedView.swift
//  kerrandsmith
//
//  Created by Sean Kelly on 25/05/2023.
//

import SwiftUI

struct OpenOrClosedView: View {
    @State private var currentTime = Calendar.current.component(.hour, from: Date()) * 100 + Calendar.current.component(.minute, from: Date())
    let today = Calendar.current.component(.weekday, from: Date())

    var isOpen: Bool {
        switch today {
        case 1: // Sunday
            return false
        case 7: // Saturday
            return currentTime <= 1300
        default: // Monday to Friday
            return currentTime <= 1730
        }
    }

    var body: some View {
        HStack (spacing: 0){
            Text(isOpen ? "Open Now" : "Closed")
                .font(.footnote)
                .fontWeight(.semibold)
            
        
            if isOpen {
                Text(", closes in \(remainingTime())")
                    .font(.footnote)
                    .fontWeight(.semibold)
                
                Spacer()
            }
        }
        .onAppear {
            startTimer()
        }
    }
    
    private func remainingTime() -> String {
        let closingTime = today == 7 ? 1300 : 1730
        let remainingMinutes = (closingTime - currentTime) % 100
        let remainingHours = (closingTime - currentTime) / 100
        return String(format: "%02d hrs %02d mins", remainingHours, remainingMinutes)
    }
    
    private func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { _ in
            currentTime = Calendar.current.component(.hour, from: Date()) * 100 + Calendar.current.component(.minute, from: Date())
        }
    }
}

struct OpenOrClosedView_Previews: PreviewProvider {
    static var previews: some View {
        OpenOrClosedView()
    }
}

