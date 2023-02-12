//
//  LandmarkDetailTests.swift
//  
//
//  Created by Doan Le Thieu on 11/02/2023.
//

import ComposableArchitecture
import XCTest
@testable import LandmarkDetail

@MainActor
final class LandmarkDetailTests: XCTestCase {

    func testToggleFavorite() async {
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

        await store.send(.favoriteButtonTapped) {
            $0.landmark.isFavorite = true
        }

        await store.send(.favoriteButtonTapped) {
            $0.landmark.isFavorite = false
        }
    }
}
