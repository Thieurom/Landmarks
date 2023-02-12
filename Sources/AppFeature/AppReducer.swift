//
//  AppReducer.swift
//  
//
//  Created by Doan Le Thieu on 29/01/2023.
//

import ComposableArchitecture
import DataManager
import Foundation
import Home
import LandmarkList
import Models

extension Bundle: @unchecked Sendable {}

public struct AppReducer: ReducerProtocol {

    public struct State: Equatable {

        public enum Tab {
            case home
            case list
        }

        public let dataPath: String
        public let dataBundle: Bundle
        public var landmarks: [Landmark] = []
        public var selectedTab = Tab.home

        private var _home: Home.State = .init()
        public var home: Home.State {
            get {
                var copy = _home
                copy.landmarks = landmarks
                return copy
            }
            set {
                landmarks = newValue.landmarks
                _home = newValue
            }
        }

        private var _landmarkList: LandmarkList.State = .init()
        public var landmarkList: LandmarkList.State {
            get {
                var copy = _landmarkList
                copy.landmarks = landmarks
                return copy
            }
            set {
                landmarks = newValue.landmarks
                _landmarkList = newValue
            }
        }

        public init(dataPath: String, dataBundle: Bundle) {
            self.dataPath = dataPath
            self.dataBundle = dataBundle
        }
    }

    public enum Action {
        case onAppear
        case tabSelected(State.Tab)
        case loadLandmarksResponse(TaskResult<[Landmark]>)
        case home(Home.Action)
        case landmarkList(LandmarkList.Action)
    }

    public var body: some ReducerProtocol<State, Action> {
        Scope(state: \.home, action: /Action.home) {
            Home()
        }

        Scope(state: \.landmarkList, action: /Action.landmarkList) {
            LandmarkList()
        }

        Reduce { state, action in
            switch action {
            case .onAppear:
                return .task { [filename = state.dataPath, bundle = state.dataBundle] in
                    await .loadLandmarksResponse(TaskResult {
                        try self.dataManager.loadLandmarks(filename, bundle)
                    })
                }
            case let .tabSelected(tab):
                state.selectedTab = tab
                return .none
            case let .loadLandmarksResponse(.success(landmarks)):
                state.landmarks = landmarks
                return .none
            case .loadLandmarksResponse(.failure):
                return .none
            case .home:
                return .none
            case .landmarkList:
                return .none
            }
        }
    }

    @Dependency(\.dataManager) private var dataManager

    public init() {}
}
