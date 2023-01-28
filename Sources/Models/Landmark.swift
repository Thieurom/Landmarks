//
//  Landmark.swift
//  
//
//  Created by Doan Le Thieu on 28/01/2023.
//

import CoreLocation

public struct Landmark: Equatable {

    public let name: String
    public let park: String
    public let state: String
    public let description: String
    public let coordinates: Coordinates
    public let imageName: String

    public init(name: String, park: String, state: String, description: String, coordinates: Coordinates, imageName: String) {
        self.name = name
        self.park = park
        self.state = state
        self.description = description
        self.coordinates = coordinates
        self.imageName = imageName
    }
}

extension Landmark {
    public static var example: Landmark = .init(
        name: "Turtle Rock",
        park: "Joshua Tree National Park",
        state: "California",
        description: "Descriptive text goes here.",
        coordinates: Coordinates(latitude: 34.011_286, longitude: -116.166_868),
        imageName: "turtlerock"
    )
}
