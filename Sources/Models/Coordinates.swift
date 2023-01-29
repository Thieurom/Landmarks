//
//  Coordinates.swift
//  
//
//  Created by Doan Le Thieu on 28/01/2023.
//

public struct Coordinates: Equatable, Decodable {

    public var latitude: Double
    public var longitude: Double

    public init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
