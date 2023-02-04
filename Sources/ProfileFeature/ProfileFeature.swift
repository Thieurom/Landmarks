//
//  ProfileFeature.swift
//  
//
//  Created by Doan Le Thieu on 04/02/2023.
//

import ComposableArchitecture
import Models

public struct ProfileFeature: ReducerProtocol {

    public struct State: Equatable {

        public var profile: Profile = .default

        public init() {}
    }

    public enum Action {
        case editButtonTapped
    }

    public init() {}

    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .editButtonTapped:
            return .none
        }
    }
}
