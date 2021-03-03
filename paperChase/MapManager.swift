//
//  MapManager.swift
//  paperChase
//
//  Created by Philippe Van Daele on 2021-02-23.
//

import MapKit
import SwiftUI
import Foundation

struct MapManager: UIViewRepresentable {
    @EnvironmentObject var coords: coordinates
    var LocationManager = CLLocationManager()
    
    class Coordinator: NSObject, MKMapViewDelegate{
        var parent: MapManager
        
        init(_ parent: MapManager) {
            self.parent = parent
        }
    }
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func setupManager(){
        LocationManager.desiredAccuracy = kCLLocationAccuracyBest
        LocationManager.requestWhenInUseAuthorization()
        LocationManager.requestAlwaysAuthorization()
    }
    
    func makeUIView(context: Context) -> MKMapView {
        setupManager()
        
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        let annotation1 = MKPointAnnotation()
        annotation1.title = "Starting point"
        annotation1.coordinate = CLLocationCoordinate2D(latitude: coords.startLat, longitude: coords.startLong)
        mapView.addAnnotation(annotation1)
        
        let annotation2 = MKPointAnnotation()
        annotation2.title = "ending point"
        annotation2.coordinate = CLLocationCoordinate2D(latitude: coords.endLat, longitude: coords.endLong)
        mapView.addAnnotation(annotation2)

        
        return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        let coordinate = CLLocationCoordinate2D(latitude: coords.startLat, longitude: coords.startLong)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        view.setRegion(region, animated: true)
        
    }
}

struct MapManager_Previews: PreviewProvider {
    static var previews: some View {
        MapManager()
    }
}
