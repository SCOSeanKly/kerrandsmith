//
//  BookingForm.swift
//  kerrandsmith
//
//  Created by Sean Kelly on 17/05/2023.
//

import SwiftUI
import SwiftUIMailView

struct BookingForm: View {
    @State private var name: String = ""
    @State private var phoneNumber: String = ""
    @State private var vehicleReg: String = ""
    @State private var mileage: String = ""
    @State private var serviceOrRepair: String = ""
    @State private var selectedDate = Date()
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var showValidation = false
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showMailView = false
    @State private var mailData = ComposeMailData(subject: "Test Subject",
                                                     recipients: ["ske@kerrandsmith.co.uk"],
                                                     message: "Here's a message",
                                                     attachments: [AttachmentData(data: "Some text".data(using: .utf8)!,
                                                                                  mimeType: "text/plain",
                                                                                  fileName: "text.txt")
                                                     ])
    
    
    var body: some View {
        ZStack{
            NavigationView {
                Form {
                
                        Section(header: Text("Customer Information")) {
                            TextField("Name", text: $name)
                                .modifier(RequiredFieldModifier(fieldValue: name, showValidation: showValidation))
                                .autocapitalization(.words)
                            TextField("Phone Number", text: $phoneNumber)
                                .modifier(RequiredFieldModifier(fieldValue: phoneNumber, showValidation: showValidation))
                                .keyboardType(.numberPad)
                            TextField("Vehicle Registration", text: $vehicleReg)
                                .autocapitalization(.allCharacters)
                            TextField("Mileage", text: $mileage)
                                .keyboardType(.numberPad)
                        }
                        .opacity(!MailView.canSendMail ? 0.3 : 1)
                        
                        Section(header: Text("Appointment Details")) {
                            TextField("Aftersales or Sales", text: $serviceOrRepair)
                                .modifier(RequiredFieldModifier(fieldValue: serviceOrRepair, showValidation: showValidation))
                            DatePicker(selection: $selectedDate, in: Date()..., displayedComponents: .date) {
                                Text("Date")
                            }
                        }
                        .opacity(!MailView.canSendMail ? 0.3 : 1)
                    
                    Section(header: Text("Next Steps")) {
                        Text(nextStepsText())
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                    
                    Section {
                        HStack{
                            Button(action: {
                                    showMailView.toggle()
                            }) {
                                Text(!MailView.canSendMail ? "\(Image(systemName: "exclamationmark.triangle")) Mail not available" : "\(Image(systemName: "envelope")) Contact Us")
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(!MailView.canSendMail ? Color.red : Color.blue)
                                    .cornerRadius(6)
                                    .minimumScaleFactor(0.5)
                            }
                        }
                        .disabled(!MailView.canSendMail)
                    }
                }
                .navigationBarTitle("Appointment")
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text(alertTitle()),
                        message: Text(alertMessage),
                        dismissButton: .default(Text("OK"), action: {
                            if alertMessage == "Your booking has been submitted successfully." {
                                resetForm()
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        })
                    )
                }
            }
        }
        .sheet(isPresented: $showMailView) {
            MailView(data: $mailData) { result in
                print(result)
            }
        }
    }
    
    private func isFormValid() -> Bool {
        return !name.isEmpty && !phoneNumber.isEmpty && !serviceOrRepair.isEmpty
    }

    /*
    private func submitBooking() {
        print("Name: \(name)")
        print("Phone Number: \(phoneNumber)")
        print("Vehicle Registration: \(vehicleReg)")
        print("Mileage: \(mileage)")
        print("Service or Repair: \(serviceOrRepair)")
        print("Date: \(selectedDate)")
    }
    */
    
    private func alertTitle() -> String {
        return alertMessage == "Your booking has been submitted successfully." ? "Booking Submitted" : "Error"
    }

    private func resetForm() {
        name = ""
        phoneNumber = ""
        vehicleReg = ""
        mileage = ""
        serviceOrRepair = ""
        selectedDate = Date()
        showValidation = false
    }
    
    private func nextStepsText() -> String {
        if !isFormValid() {
            
            if !MailView.canSendMail {
                return "There is a problem with the mail server.\n\nCall us on 01290 422440"
            }
            
            return "Complete the fields with the required information."
        } else {
            return "Once you submit your appointment request, our representative will be in touch with you to confirm your appointment."
        }
    }
}


struct BookingForm_Previews: PreviewProvider {
    static var previews: some View {
        BookingForm()
    }
}
