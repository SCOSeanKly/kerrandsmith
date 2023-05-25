//
//  ShowRoomView.swift
//  kerrandsmith
//
//  Created by Sean Kelly on 15/05/2023.
//

import SwiftUI
import SwiftUIMailView

struct ServicesView: View {
    
    let screenWidth = UIScreen.main.bounds.width
    let imageVWidth = UIScreen.main.bounds.width * 0.48
    let imageVHeight = UIScreen.main.bounds.width * 0.45
    let imageHWidth = UIScreen.main.bounds.width * 0.98
    let imageHHeight = UIScreen.main.bounds.width * 0.45
    let imageLargeHeight = UIScreen.main.bounds.width * 0.8
    let textHeight = UIScreen.main.bounds.width * 0.3

    
    @Binding var showBookingForm: Bool
    
    @State private var showMailView = false
    @State private var mailData = ComposeMailData(subject: "Enquiry to Kerr & Smith Cumnock",
                                                     recipients: ["ske@kerrandsmith.co.uk"],
                                                     message: "I have an enquiry. Can you contact me please.",
                                                     attachments: [])
    
    
    
    var body: some View {
        VStack {
            VStack {
                ZStack {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(height: 60)
                    
                    HStack {
                        Text("SERVICES")
                            .font(.title2)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .padding()
                }
            }
            ScrollView (showsIndicators: false){
                
                ServicesVerticalView(imageName: "workshop", imageWidth: imageHWidth, imageHeight: imageLargeHeight, titleText: "Service", subTitleText: servicesBlock[0], lineLimit: 2, showBookingFormButton: true, bookingFormButtonText: "Contact our Service Department", showBookingForm: $showBookingForm, showMore: true)
                
                ServicesNews()
                   .padding(.top)
                    .padding(.horizontal, 10)
                
                
                
                HStack (alignment: .top) {
                    
                    ServicesVerticalView(imageName: "parts", imageWidth: imageVWidth, imageHeight: imageVHeight, titleText: "Parts", subTitleText: servicesBlock[1], lineLimit: 2, showBookingFormButton: false, bookingFormButtonText: "Contact our Parts Department", showBookingForm: $showBookingForm, showMore: true)
                    
                    Spacer()
                    
                    ServicesVerticalView(imageName: "bodyshop", imageWidth: imageVWidth, imageHeight: imageVHeight, titleText: "Accident Repair", subTitleText: servicesBlock[2], lineLimit: 2, showBookingFormButton: false, bookingFormButtonText: "Make a Booking", showBookingForm: $showBookingForm, showMore: true)
                }
                .padding()
                
                ServicesNews2()
                   .padding(.bottom)
                    .padding(.horizontal, 10)
                
                ServicesVerticalView(imageName: "sales", imageWidth: imageHWidth, imageHeight: imageHHeight, titleText: "Sales", subTitleText: servicesBlock[3], lineLimit: 2, showBookingFormButton: true, bookingFormButtonText: "Contact our Sales Team", showBookingForm: $showBookingForm, showMore: true)
                
                ServicesNews3()
                    .padding(.horizontal, 10)
                    .padding(.top)
                
                
                HStack (alignment: .top) {
                    
                    ServicesVerticalView(imageName: "trailers", imageWidth: imageVWidth, imageHeight: imageVHeight, titleText: "Brian James Trailers", subTitleText: servicesBlock[4], lineLimit: 2, showBookingFormButton: false, bookingFormButtonText: "Contact our Trailer Specialist", showBookingForm: $showBookingForm, showMore: true)
                    
                    Spacer()
                    
                    ServicesVerticalView(imageName: "image2", imageWidth: imageVWidth, imageHeight: imageVHeight, titleText: "Placeholder", subTitleText: servicesBlock[4], lineLimit: 2, showBookingFormButton: false, bookingFormButtonText: "Do Something?", showBookingForm: $showBookingForm, showMore: true)
                    
                }
                .padding()
                
                Spacer()
            }
          
        }
        .sheet(isPresented: $showBookingForm){
            MailView(data: $mailData) { result in
                print(result)
            }
        }
    }
}

struct ShowRoomView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .preferredColorScheme(.light)
            .environment(\.colorScheme, .light) // or .light
            .environment(\.sizeCategory, .small)
    }
}
