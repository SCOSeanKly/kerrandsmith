//
//  ContactUsMapView.swift
//  kerrandsmith
//
//  Created by Sean Kelly on 18/05/2023.
//

import SwiftUI
import MapKit

struct MapImageView: View {
    
    let locationCoordinate = CLLocationCoordinate2D(latitude: 55.45016, longitude: -4.27010)

    
    var body: some View {
        ZStack {
            MapView(coordinate: locationCoordinate)
            
            HStack {
                Spacer()
                
                VStack {
                    Spacer()
                    
                    Button(action: openAppleMaps) {
                        
                        ZStack {
                            Circle()
                                .foregroundColor(.white)
                                .frame(width: 35)
                            Image(systemName: "car")
                                .foregroundColor(.blue)
                        }
                        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 0)
                    }
                    .padding()
                    
                }
            }
            
        }
        .customFrame()
    }
    func openAppleMaps() {
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: locationCoordinate))
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
}

struct MapImageView_Previews: PreviewProvider {
    static var previews: some View {
        MapImageView()
    }
}
