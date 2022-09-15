//
//  MapView.swift
//  Party Finder
//
//  Created by Alexandria Armknecht on 5/1/22.
//

import SwiftUI
import MapKit

struct MyAnnotationItem: Identifiable {
    var coordinate: CLLocationCoordinate2D
    let id = UUID()
}

struct MapView: View {
    @State private var region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 33.968_447, longitude: -118.416_614),
            span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        )
    @State var parties: [Party]
    @State var coordinates: [Coordinates] = []
    @State private var errorOccurred = false
    @State var annotationItems: [MyAnnotationItem] = []
    
//    var annotationItems: [MyAnnotationItem] = [
//            MyAnnotationItem(coordinate: CLLocationCoordinate2D(latitude: 33.969903, longitude: -118.420329)),
//            MyAnnotationItem(coordinate: CLLocationCoordinate2D(latitude: 33.971700, longitude: -118.414725)),
//        ]
    
    var body: some View {
       
        Map(coordinateRegion: $region, annotationItems: annotationItems) {item in
                MapPin(coordinate: item.coordinate)
            }
        .task {
            //fetching = true

            for party in parties {
                do {
                    let results = try await getLocation(address: party.address)
                    coordinates.append(results.results[0].geometry.location)
                }
                catch {
                    errorOccurred = true
                    debugPrint("Unexpected error: \(error)")
                }
            }
            
            for item in coordinates {
                annotationItems.append(MyAnnotationItem(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.lng)))
            }
        }
    }
    
    func loadData() async {
        for party in parties {
            do {
                let results = try await getLocation(address: party.address)
                //coordinates.append(results.response[0].location)
            }
            catch {
                errorOccurred = true
                debugPrint("Unexpected error: \(error)")
            }
        }
    }
    
}



struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(parties: [])
    }
}
