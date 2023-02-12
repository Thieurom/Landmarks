import ComposableArchitecture
import DataManager
import Home
import Models
import LandmarkList
import XCTest
@testable import AppFeature

@MainActor
final class AppFeatureTests: XCTestCase {

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
            initialState: AppReducer.State(dataPath: "", dataBundle: .main),
            reducer: AppReducer()
        ) {
            $0.dataManager.loadLandmarks = { _, _ in self.landmarks }
        }

        XCTAssertTrue(store.state.landmarks.isEmpty)
        XCTAssertTrue(store.state.home.landmarks.isEmpty)
        XCTAssertTrue(store.state.landmarkList.landmarks.isEmpty)

        await store.send(.onAppear)
        await store.receive(/AppReducer.Action.loadLandmarksResponse(.success(landmarks))) {
            $0.landmarks = self.landmarks
        }

        XCTAssertEqual(store.state.home.landmarks, landmarks)
        XCTAssertEqual(store.state.landmarkList.landmarks, landmarks)
    }

    func testOnAppearFailToLoadLandmarks() async {
        let store = TestStore(
            initialState: AppReducer.State(dataPath: "", dataBundle: .main),
            reducer: AppReducer()
        ) {
            $0.dataManager.loadLandmarks = { _, _ in throw Error.fileNotFound }
        }

        XCTAssertTrue(store.state.landmarks.isEmpty)
        XCTAssertTrue(store.state.home.landmarks.isEmpty)
        XCTAssertTrue(store.state.landmarkList.landmarks.isEmpty)

        await store.send(.onAppear)
        await store.receive(/AppReducer.Action.loadLandmarksResponse(.failure(Error.fileNotFound)))

        XCTAssertTrue(store.state.home.landmarks.isEmpty)
        XCTAssertTrue(store.state.landmarkList.landmarks.isEmpty)
    }

    func testSelectTab() async {
        let store = TestStore(
            initialState: AppReducer.State(dataPath: "", dataBundle: .main),
            reducer: AppReducer()
        )

        XCTAssertEqual(store.state.selectedTab, .home)

        await store.send(.tabSelected(.list)) {
            $0.selectedTab = .list
        }

        await store.send(.tabSelected(.home)) {
            $0.selectedTab = .home
        }
    }
}
