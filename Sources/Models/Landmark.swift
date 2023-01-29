//
//  Landmark.swift
//  
//
//  Created by Doan Le Thieu on 28/01/2023.
//

import CoreLocation

public struct Landmark: Equatable, Decodable {

    public enum Category: String, CaseIterable, Decodable {
        case lakes = "Lakes"
        case rivers = "Rivers"
        case mountains = "Mountains"
    }

    public let id: Int
    public let name: String
    public let park: String
    public let state: String
    public let description: String
    public let coordinates: Coordinates
    public let category: Category
    public let imageName: String
    public var isFavorite: Bool
    public var isFeatured: Bool

    public init(id: Int, name: String, park: String, state: String, description: String, coordinates: Coordinates, category: Category, imageName: String, isFavorite: Bool, isFeatured: Bool) {
        self.id = id
        self.name = name
        self.park = park
        self.state = state
        self.description = description
        self.coordinates = coordinates
        self.category = category
        self.imageName = imageName
        self.isFavorite = isFavorite
        self.isFeatured = isFeatured
    }
}

extension Landmark {
    public static var sampleData: [Landmark] = [
    .init(
        id: 1001,
        name: "Turtle Rock",
        park: "Joshua Tree National Park",
        state: "California",
        description: "Suscipit inceptos est felis purus aenean aliquet adipiscing diam venenatis, augue nibh duis neque aliquam tellus condimentum sagittis vivamus, cras ante etiam sit conubia elit tempus accumsan libero, mattis per erat habitasse cubilia ligula penatibus curae. Sagittis lorem augue arcu blandit libero molestie non ullamcorper, finibus imperdiet iaculis ad quam per luctus neque, ligula curae mauris parturient diam auctor eleifend laoreet ridiculus, hendrerit adipiscing sociosqu pretium nec velit aliquam. Inceptos egestas maecenas imperdiet eget id donec nisl curae congue, massa tortor vivamus ridiculus integer porta ultrices venenatis aliquet, curabitur et posuere blandit magnis dictum auctor lacinia, eleifend dolor in ornare vulputate ipsum morbi felis. Faucibus cursus malesuada orci ultrices diam nisl taciti torquent, tempor eros suspendisse euismod condimentum dis velit mi tristique, a quis etiam dignissim dictum porttitor lobortis ad fermentum, sapien consectetur dui dolor purus elit pharetra. Interdum mattis sapien ac orci vestibulum vulputate laoreet proin hac, maecenas mollis ridiculus morbi praesent cubilia vitae ligula vel, sem semper volutpat curae mauris justo nisl luctus, non eros primis ultrices nascetur erat varius integer.",
        coordinates: Coordinates(latitude: 34.011_286, longitude: -116.166_868),
        category: .rivers,
        imageName: "turtlerock",
        isFavorite: true,
        isFeatured: true
    ),
    .init(
        id: 1002,
        name: "Silver Salmon Creek",
        park: "Lake Clark National Park and Preserve",
        state: "Alaska",
        description: "Suscipit inceptos est felis purus aenean aliquet adipiscing diam venenatis, augue nibh duis neque aliquam tellus condimentum sagittis vivamus, cras ante etiam sit conubia elit tempus accumsan libero, mattis per erat habitasse cubilia ligula penatibus curae. Sagittis lorem augue arcu blandit libero molestie non ullamcorper, finibus imperdiet iaculis ad quam per luctus neque, ligula curae mauris parturient diam auctor eleifend laoreet ridiculus, hendrerit adipiscing sociosqu pretium nec velit aliquam. Inceptos egestas maecenas imperdiet eget id donec nisl curae congue, massa tortor vivamus ridiculus integer porta ultrices venenatis aliquet, curabitur et posuere blandit magnis dictum auctor lacinia, eleifend dolor in ornare vulputate ipsum morbi felis. Faucibus cursus malesuada orci ultrices diam nisl taciti torquent, tempor eros suspendisse euismod condimentum dis velit mi tristique, a quis etiam dignissim dictum porttitor lobortis ad fermentum, sapien consectetur dui dolor purus elit pharetra. Interdum mattis sapien ac orci vestibulum vulputate laoreet proin hac, maecenas mollis ridiculus morbi praesent cubilia vitae ligula vel, sem semper volutpat curae mauris justo nisl luctus, non eros primis ultrices nascetur erat varius integer.",
        coordinates: Coordinates(latitude: 59.980167, longitude: -152.665167),
        category: .lakes,
        imageName: "silversalmoncreek",
        isFavorite: false,
        isFeatured: false
    )
    ]
}
