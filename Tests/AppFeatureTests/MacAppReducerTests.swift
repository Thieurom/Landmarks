//
//  MacReducerTests.swift
//  
//
//  Created by Doan Le Thieu on 18/02/2023.
//

import ComposableArchitecture
import DataManager
import Home
import Models
import LandmarkList
import XCTest
@testable import AppFeature

@MainActor
final class MacReducerTests: XCTestCase {

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

    func testOnAppearSucceedInLoadingLandmarks() async {
        let store = TestStore(
            initialState: MacAppReducer.State(dataPath: "", dataBundle: .main),
            reducer: MacAppReducer()
        ) {
            $0.dataManager.loadLandmarks = { _, _ in self.landmarks }
        }

        XCTAssertTrue(store.state.landmarkList.landmarks.isEmpty)

        await store.send(.onAppear)
        await store.receive(/MacAppReducer.Action.loadLandmarksResponse(.success(landmarks))) {
            $0.landmarkList.landmarks = self.landmarks
        }

        XCTAssertEqual(store.state.landmarkList.landmarks, landmarks)
    }

    func testOnAppearFailToLoadLandmarks() async {
        let store = TestStore(
            initialState: MacAppReducer.State(dataPath: "", dataBundle: .main),
            reducer: MacAppReducer()
        ) {
            $0.dataManager.loadLandmarks = { _, _ in throw Error.fileNotFound }
        }

        XCTAssertTrue(store.state.landmarkList.landmarks.isEmpty)
        XCTAssertTrue(store.state.landmarkList.landmarks.isEmpty)

        await store.send(.onAppear)
        await store.receive(/MacAppReducer.Action.loadLandmarksResponse(.failure(Error.fileNotFound)))

        XCTAssertTrue(store.state.landmarkList.landmarks.isEmpty)
    }

    func testToggleFavoriteLandmarkCommands() async {
        let store = TestStore(
            initialState: MacAppReducer.State(dataPath: "", dataBundle: .main),
            reducer: MacAppReducer()
        ) {
            $0.dataManager.loadLandmarks = { _, _ in throw Error.fileNotFound }
        }

        XCTAssertNil(store.state.selectedLandmark)
        await store.send(.commands(.landmarkFavoriteToggled))
    }
}

