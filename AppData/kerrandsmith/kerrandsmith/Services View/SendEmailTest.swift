//
//  SendEmailTest.swift
//  kerrandsmith
//
//  Created by Sean Kelly on 20/05/2023.
//

import SwiftUI
import SwiftUIMailView

struct SendEmailTest: View {
    
    @State private var showMailView = false
    @State private var mailData = ComposeMailData(subject: "",
                                                     recipients: ["ske@kerrandsmith.co.uk"],
                                                     message: "Here's a message",
                                                     attachments: [AttachmentData(data: "Some text".data(using: .utf8)!,
                                                                                  mimeType: "text/plain",
                                                                                  fileName: "text.txt")
                                                     ])
    
    
    
    
    var body: some View {
        Button(action: {
                showMailView.toggle()
            }) {
                Text("Send mail")
            }
            .disabled(!MailView.canSendMail)
            .sheet(isPresented: $showMailView) {
                MailView(data: $mailData) { result in
                    print(result)
                }
            }
    }
}

struct SendEmailTest_Previews: PreviewProvider {
    static var previews: some View {
        SendEmailTest()
    }
}
