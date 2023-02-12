//
//  HomeTests.swift
//  
//
//  Created by Doan Le Thieu on 12/02/2023.
//

import ComposableArchitecture
import Models
import LandmarkDetail
import ProfileDetail
import XCTest
@testable import Home

@MainActor
final class HomeTests: XCTestCase {

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
            isFeatured: true
        )
    ]

    func testSelectFeatureLandmark() async {
        let state = Home.State(landmarks: landmarks)
        let store = TestStore(initialState: state, reducer: Home())

        XCTAssertEqual(store.state.features, landmarks)
        XCTAssertEqual(store.state.categories, [
            Landmark.Category.lakes: [landmarks[0]],
            Landmark.Category.mountains: [landmarks[1]]
        ])

        XCTAssertEqual(store.state.featureIndex, 0)
        await store.send(.featureIndexChanged(1)) {
            $0.featureIndex = 1
        }
    }

    func testSelectLandmark() async {
        let state = Home.State(landmarks: landmarks)
        let store = TestStore(initialState: state, reducer: Home())

        XCTAssertEqual(store.state.landmarks, landmarks)

        await store.send(.setNavigation(selection: 1)) {
            $0.selectedLandmark = LandmarkDetail.State(landmark: self.landmarks[0])
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
                    isFeatured: true
                )
            ]
        }

        await store.send(.setNavigation(selection: nil)) {
            $0.selectedLandmark = nil
        }
    }

    func testShowProfile() async {
        let state = Home.State(landmarks: landmarks)
        let store = TestStore(initialState: state, reducer: Home())

        await store.send(.setSheet(isPresented: true)) {
            $0.isSheetPresented = true
            $0.profileDetail = ProfileDetail.State(profile: .default)
        }

        await store.send(.profileDetail(.doneButtonTapped))

        await store.send(.setSheet(isPresented: false)) {
            $0.isSheetPresented = false
            $0.profileDetail = nil
        }
    }
}
