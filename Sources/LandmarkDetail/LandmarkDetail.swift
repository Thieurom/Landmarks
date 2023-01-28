//
//  LandmarkDetail.swift
//  
//
//  Created by Doan Le Thieu on 28/01/2023.
//

import ComposableArchitecture
import Models

public struct LandmarkDetail: ReducerProtocol {

    public struct State: Equatable {

        public var landmark: Landmark

        public init(landmark: Landmark) {
            self.landmark = landmark
        }
    }

    public enum Action {
        case favoriteButtonTapped
    }

    public init() {}

    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .favoriteButtonTapped:
            return .none
        }
    }
}
