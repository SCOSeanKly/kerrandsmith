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
            let closingTime = today == 6 ? 1300 : 1730
            return currentTime <= closingTime
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
        
        // Convert closingTime to 12-hour format
        let closingHours = closingTime / 100
        let closingMinutes = closingTime % 100
        let formattedClosingTime = Calendar.current.date(bySettingHour: closingHours, minute: closingMinutes, second: 0, of: Date()) ?? Date()

        let remainingMinutes = Calendar.current.dateComponents([.minute], from: Date(), to: formattedClosingTime).minute ?? 0
        let remainingHours = remainingMinutes / 60
        let remainingMinutesMod60 = remainingMinutes % 60

        let hoursText = remainingHours < 2 ? "hr" : "hrs"
        let minutesText = remainingMinutesMod60 < 2 ? "min" : "mins"
        
        return String(format: "%02d %@ %02d %@", remainingHours, hoursText, remainingMinutesMod60, minutesText)
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

