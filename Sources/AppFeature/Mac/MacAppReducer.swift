//
//  MacAppReducer.swift
//  
//
//  Created by Doan Le Thieu on 14/02/2023.
//

import ComposableArchitecture
import DataManager
import Foundation
import Home
import LandmarkList
import Models

public struct MacAppReducer: ReducerProtocol {

    public struct State: Equatable {
        public let dataPath: String
        public let dataBundle: Bundle
        public var landmarkList: LandmarkList.State = .init()

        public var selectedLandmark: Landmark? {
            get {
                landmarkList.selectedLandmark?.value.landmark
            }
            set {
                landmarkList.landmarks = landmarkList.landmarks
                    .map { landmark in
                        guard let newValue = newValue, landmark.id == newValue.id else {
                            return landmark
                        }

                        var copy = landmark
                        copy.isFavorite = newValue.isFavorite
                        return copy
                    }
            }
        }

        public init(dataPath: String, dataBundle: Bundle) {
            self.dataPath = dataPath
            self.dataBundle = dataBundle
        }
    }

    public struct SceneState: Equatable {
        public let favoriteCommandTitle: String
        public let isFavoriteCommandEnabled: Bool

        public init(state: State) {
            self.favoriteCommandTitle = "\(state.selectedLandmark?.isFavorite == true ? "Remove" : "Mark") as Favorite"
            self.isFavoriteCommandEnabled = state.selectedLandmark != nil
        }
    }

    public enum CommandAction {
        case landmarkFavoriteToggled
    }

    public enum Action {
        case onAppear
        case loadLandmarksResponse(TaskResult<[Landmark]>)
        case landmarkList(LandmarkList.Action)
        case commands(CommandAction)
    }

    public var body: some ReducerProtocol<State, Action> {
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
            case let .loadLandmarksResponse(.success(landmarks)):
                state.landmarkList.landmarks = landmarks
                return .none
            case .loadLandmarksResponse(.failure):
                return .none
            case .landmarkList:
                return .none
            case .commands(.landmarkFavoriteToggled):
                state.selectedLandmark?.isFavorite.toggle()
                return .none
            }
        }
    }

    @Dependency(\.dataManager) private var dataManager

    public init() {}
}
