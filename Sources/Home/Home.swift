//
//  Home.swift
//  
//
//  Created by Doan Le Thieu on 29/01/2023.
//

import ComposableArchitecture
import LandmarkDetail
import Models

public struct Home: ReducerProtocol {

    public struct State: Equatable {
        public var landmarks: [Landmark]
        public var selectedLandmark: LandmarkDetail.State?

        public init(landmarks: [Landmark] = []) {
            self.landmarks = landmarks
        }

        public var categories: [Landmark.Category: [Landmark]] {
            Dictionary(
                grouping: landmarks,
                by: { $0.category }
            )
        }
    }

    public enum Action {
        case setNavigation(selection: Int?)
        case landmark(LandmarkDetail.Action)
    }

    public init() {}

    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case let .setNavigation(selection: .some(id)):
                state.selectedLandmark = state.landmarks
                    .first(where: { $0.id == id })
                    .map(LandmarkDetail.State.init)
                return .none
            case .setNavigation(selection: .none):
                state.selectedLandmark = nil
                return .none
            case .landmark:
                return .none
            }
        }
        .ifLet(\.selectedLandmark, action: /Action.landmark) {
            Scope(state: /.self, action: /.self) {
                LandmarkDetail()
            }
        }
    }
}
