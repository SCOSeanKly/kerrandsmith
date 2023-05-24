//
//  MapView.swift
//  kerrandsmith
//
//  Created by Sean Kelly on 15/05/2023.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    let coordinate: CLLocationCoordinate2D
    let delta: CLLocationDegrees = 0.006

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        mapView.delegate = context.coordinator
        return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        let span = MKCoordinateSpan(latitudeDelta: delta, longitudeDelta: delta)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        view.setRegion(region, animated: true)

        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        view.addAnnotation(annotation)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        let parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }

        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let identifier = "CustomPin"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

            if annotationView == nil {
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = false
                annotationView?.image = UIImage(named: "customPin")

                // Scale the image
                let scale = CGFloat(0.5) // Adjust the scale as needed
                let transform = CGAffineTransform(scaleX: scale, y: scale)
                annotationView?.transform = transform
            } else {
                annotationView?.annotation = annotation
            }

            return annotationView
        }

    }
}





