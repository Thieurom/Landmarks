//
//  LandmarkList.swift
//  
//
//  Created by Doan Le Thieu on 28/01/2023.
//

import ComposableArchitecture
import LandmarkDetail
import Models

extension Landmark: Identifiable {}

public struct LandmarkList: ReducerProtocol {

    public struct State: Equatable {
        public var landmarks: IdentifiedArrayOf<Landmark>
        public var selectedLandmark: Identified<Landmark.ID, LandmarkDetail.State>?

        public init(landmarks: [Landmark] = []) {
            self.landmarks = .init(uniqueElements: landmarks)
        }
    }

    public enum Action {
        case setNavigation(selection: Int?)
        case landmark(LandmarkDetail.Action)
    }

    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case let .setNavigation(selection: .some(id)):
                state.selectedLandmark = state.landmarks[id: id]
                    .map { landmark in
                        Identified(
                            LandmarkDetail.State(landmark: landmark),
                            id: id
                        )
                    }
                return .none
            case .setNavigation(selection: .none):
                state.selectedLandmark = nil
                return .none
            case .landmark:
                return .none
            }
        }
        .ifLet(\.selectedLandmark, action: /Action.landmark) {
            Scope(
                state: \Identified<Landmark.ID, LandmarkDetail.State>.value,
                action: /.self
            ) {
                LandmarkDetail()
            }
        }
    }

    public init() {}
}
