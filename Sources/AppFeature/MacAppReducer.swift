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

        public init(dataPath: String, dataBundle: Bundle) {
            self.dataPath = dataPath
            self.dataBundle = dataBundle
        }
    }

    public enum Action {
        case onAppear
        case loadLandmarksResponse(TaskResult<[Landmark]>)
        case landmarkList(LandmarkList.Action)
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
            }
        }
    }

    @Dependency(\.dataManager) private var dataManager

    public init() {}
}
