//
//  ProfileDetail.swift
//  
//
//  Created by Doan Le Thieu on 04/02/2023.
//

import ComposableArchitecture
import Models

public struct ProfileDetail: ReducerProtocol {

    public struct State: Equatable {
        public var profile: Profile
        public var profileInEditing: Profile
        public var isEditingProfile = false

        public init(profile: Profile) {
            self.profile = profile
            self.profileInEditing = profile
        }
    }

    public enum Action {
        case editButtonTapped
        case doneButtonTapped
        case cancelButtonTapped
        case profileUpdated(Profile)
    }

    public init() {}

    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .editButtonTapped:
            state.profileInEditing = state.profile
            state.isEditingProfile = true
            return .none
        case .doneButtonTapped:
            state.profile = state.profileInEditing
            state.isEditingProfile = false
            return .none
        case .cancelButtonTapped:
            state.profileInEditing = state.profile
            state.isEditingProfile = false
            return .none
        case let .profileUpdated(profile):
            state.profileInEditing = profile
            return .none
        }
    }
}
