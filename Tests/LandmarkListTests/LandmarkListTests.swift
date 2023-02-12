//
//  LandmarkListTests.swift
//  
//
//  Created by Doan Le Thieu on 12/02/2023.
//

import ComposableArchitecture
import Models
import LandmarkDetail
import XCTest
@testable import LandmarkList

@MainActor
final class LandmarkListTests: XCTestCase {

    let landmarks: [Landmark] = [
        .init(
            id: 1,
            name: "",
            park: "",
            state: "",
            description: "",
            coordinates: .init(latitude: 1, longitude: 1),
            category: .lakes,
            imageName: "",
            isFavorite: false,
            isFeatured: true
        ),
        .init(
            id: 2,
            name: "",
            park: "",
            state: "",
            description: "",
            coordinates: .init(latitude: 2, longitude: 2),
            category: .mountains,
            imageName: "",
            isFavorite: true,
            isFeatured: false
        )
    ]

    func testSelectFilterCategory() async {
        let state = LandmarkList.State(
            landmarks: landmarks
        )

        let store = TestStore(
            initialState: state,
            reducer: LandmarkList()
        )

        await store.send(.filterSelected(.lakes)) {
            $0.filter = .lakes
        }
        XCTAssertEqual(store.state.title, "Lakes")
        XCTAssertEqual(store.state.filteredLanmarks, [
            Landmark(
                id: 1,
                name: "",
                park: "",
                state: "",
                description: "",
                coordinates: .init(latitude: 1, longitude: 1),
                category: .lakes,
                imageName: "",
                isFavorite: false,
                isFeatured: true
            )
        ])

        await store.send(.filterSelected(.mountains)) {
            $0.filter = .mountains
        }
        XCTAssertEqual(store.state.title, "Mountains")
        XCTAssertEqual(store.state.filteredLanmarks, [
            Landmark(
                id: 2,
                name: "",
                park: "",
                state: "",
                description: "",
                coordinates: .init(latitude: 2, longitude: 2),
                category: .mountains,
                imageName: "",
                isFavorite: true,
                isFeatured: false
            )
        ])

        await store.send(.filterSelected(.rivers)) {
            $0.filter = .rivers
        }
        XCTAssertEqual(store.state.title, "Rivers")
        XCTAssertTrue(store.state.filteredLanmarks.isEmpty)

        await store.send(.filterSelected(.all)) {
            $0.filter = .all
        }
        XCTAssertEqual(store.state.title, "Landmarks")
        XCTAssertEqual(store.state.filteredLanmarks, [
            Landmark(
                id: 1,
                name: "",
                park: "",
                state: "",
                description: "",
                coordinates: .init(latitude: 1, longitude: 1),
                category: .lakes,
                imageName: "",
                isFavorite: false,
                isFeatured: true
            ),
            Landmark(
                id: 2,
                name: "",
                park: "",
                state: "",
                description: "",
                coordinates: .init(latitude: 2, longitude: 2),
                category: .mountains,
                imageName: "",
                isFavorite: true,
                isFeatured: false
            )
        ])
    }

    func testToggleFavorite() async {
        let state = LandmarkList.State(
            landmarks: landmarks
        )

        let store = TestStore(
            initialState: state,
            reducer: LandmarkList()
        )
        store.exhaustivity = .off(showSkippedAssertions: true)

        await store.send(.favoriteToggled) {
            $0.showFavoritesOnly = true
        }
        XCTAssertEqual(store.state.title, "Favorite Landmarks")
        XCTAssertEqual(store.state.filteredLanmarks, [
            Landmark(
                id: 2,
                name: "",
                park: "",
                state: "",
                description: "",
                coordinates: .init(latitude: 2, longitude: 2),
                category: .mountains,
                imageName: "",
                isFavorite: true,
                isFeatured: false
            )
        ])

        await store.send(.filterSelected(.rivers)) { _ in }
        XCTAssertEqual(store.state.title, "Favorite Rivers")
        XCTAssertTrue(store.state.filteredLanmarks.isEmpty)

        await store.send(.filterSelected(.lakes)) { _ in }
        XCTAssertEqual(store.state.title, "Favorite Lakes")
        XCTAssertTrue(store.state.filteredLanmarks.isEmpty)

        await store.send(.filterSelected(.mountains)) { _ in }
        XCTAssertEqual(store.state.title, "Favorite Mountains")
        XCTAssertEqual(store.state.filteredLanmarks, [
            Landmark(
                id: 2,
                name: "",
                park: "",
                state: "",
                description: "",
                coordinates: .init(latitude: 2, longitude: 2),
                category: .mountains,
                imageName: "",
                isFavorite: true,
                isFeatured: false
            )
        ])

        await store.send(.favoriteToggled) {
            $0.showFavoritesOnly = false
        }
        XCTAssertEqual(store.state.title, "Mountains")
        XCTAssertEqual(store.state.filteredLanmarks, [
            Landmark(
                id: 2,
                name: "",
                park: "",
                state: "",
                description: "",
                coordinates: .init(latitude: 2, longitude: 2),
                category: .mountains,
                imageName: "",
                isFavorite: true,
                isFeatured: false
            )
        ])

        await store.send(.filterSelected(.all)) { _ in }
        XCTAssertEqual(store.state.title, "Landmarks")
        XCTAssertEqual(store.state.filteredLanmarks, [
            Landmark(
                id: 1,
                name: "",
                park: "",
                state: "",
                description: "",
                coordinates: .init(latitude: 1, longitude: 1),
                category: .lakes,
                imageName: "",
                isFavorite: false,
                isFeatured: true
            ),
            Landmark(
                id: 2,
                name: "",
                park: "",
                state: "",
                description: "",
                coordinates: .init(latitude: 2, longitude: 2),
                category: .mountains,
                imageName: "",
                isFavorite: true,
                isFeatured: false
            )
        ])
    }

    func testSelectLandmark() async {
        let state = LandmarkList.State(
            landmarks: landmarks
        )

        let store = TestStore(
            initialState: state,
            reducer: LandmarkList()
        )

        await store.send(.setNavigation(selection: 1)) {
            $0.selectedLandmark = Identified(
                LandmarkDetail.State(landmark: self.landmarks[0]), id: 1)
        }

        await store.send(.landmark(.favoriteButtonTapped)) {
            $0.landmarks = [
                Landmark(
                    id: 1,
                    name: "",
                    park: "",
                    state: "",
                    description: "",
                    coordinates: .init(latitude: 1, longitude: 1),
                    category: .lakes,
                    imageName: "",
                    isFavorite: true,
                    isFeatured: true
                ),
                Landmark(
                    id: 2,
                    name: "",
                    park: "",
                    state: "",
                    description: "",
                    coordinates: .init(latitude: 2, longitude: 2),
                    category: .mountains,
                    imageName: "",
                    isFavorite: true,
                    isFeatured: false
                )
            ]
        }

        await store.send(.setNavigation(selection: nil)) {
            $0.selectedLandmark = nil
        }
    }
}
