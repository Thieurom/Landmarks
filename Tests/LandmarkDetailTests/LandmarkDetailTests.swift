//
//  LandmarkDetailTests.swift
//  
//
//  Created by Doan Le Thieu on 11/02/2023.
//

import ComposableArchitecture
import XCTest
@testable import LandmarkDetail

final class LandmarkDetailTests: XCTestCase {

    func testToggleFavorite() {
        let state = LandmarkDetail.State(
            landmark: .init(
                id: 1,
                name: "",
                park: "",
                state: "",
                description: "",
                coordinates: .init(latitude: 0, longitude: 0),
                category: .lakes,
                imageName: "",
                isFavorite: false,
                isFeatured: false
            )
        )

        let store = TestStore(
            initialState: state,
            reducer: LandmarkDetail()
        )

        store.send(.favoriteButtonTapped) {
            $0.landmark.isFavorite = true
        }

        store.send(.favoriteButtonTapped) {
            $0.landmark.isFavorite = false
        }
    }
}
