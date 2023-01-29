//
//  MapView.swift
//  
//
//  Created by Doan Le Thieu on 28/01/2023.
//

import MapKit
import Models
import SwiftUI

struct MapView: View {

    let coordinates: Coordinates

    private var region: MKCoordinateRegion {
        .init(
            center: CLLocationCoordinate2D(
                latitude: coordinates.latitude,
                longitude: coordinates.longitude
            ),
            span: MKCoordinateSpan(
                latitudeDelta: 0.2,
                longitudeDelta: 0.2
            )
        )
    }

    var body: some View {
        Map(coordinateRegion: .constant(region))
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(
            coordinates: Coordinates(
                latitude: 34,
                longitude: 116
            )
        )
    }
}
