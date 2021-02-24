//
//  MapManager.swift
//  paperChase
//
//  Created by Philippe Van Daele on 2021-02-23.
//

import MapKit
import SwiftUI

struct MapManager: UIViewRepresentable {
    
    class Coordinator: NSObject, MKMapViewDelegate{
        var parent: MapManager
        
        init(_ parent: MapManager) {
            self.parent = parent
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            print(mapView.centerCoordinate)
        }
    }
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        let annotation = MKPointAnnotation()
        annotation.title = "Starting point"
        annotation.coordinate = CLLocationCoordinate2D(latitude: 56.1621073, longitude: 15.5866422)
        mapView.addAnnotation(annotation)
        
        
        return mapView
        
        
        
    }

    func updateUIView(_ view: MKMapView, context: Context) {
            
    }
}

struct MapManager_Previews: PreviewProvider {
    static var previews: some View {
        MapManager()
    }
}
