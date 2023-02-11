//
//  ProfileEditor.swift
//  
//
//  Created by Doan Le Thieu on 06/02/2023.
//

import ComposableArchitecture
import Foundation
import Models

public struct ProfileEditor: ReducerProtocol {

    public struct State: Equatable {
        public var profile: Profile

        public init(profile: Profile) {
            self.profile = profile
        }

        public var dateRange: ClosedRange<Date> {
            let min = Calendar.current.date(byAdding: .year, value: -1, to: profile.goalDate)!
            let max = Calendar.current.date(byAdding: .year, value: 1, to: profile.goalDate)!
            return min...max
        }
    }

    public enum Action {
        case usernameChanged(String)
        case notificationEnabled(Bool)
        case seasonalPhotoUpdated(Profile.Season)
        case goalDateUpdated(Date)
        case doneButtonTapped
        case cancelButtonTapped
    }

    public init() {}

    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case let .usernameChanged(name):
            state.profile.username = name
            return .none
        case let .notificationEnabled(isEnabled):
            state.profile.prefersNotifications = isEnabled
            return .none
        case let .seasonalPhotoUpdated(photo):
            state.profile.seasonalPhoto = photo
            return .none
        case let .goalDateUpdated(date):
            state.profile.goalDate = date
            return .none
        case .doneButtonTapped:
            return .none
        case .cancelButtonTapped:
            return .none
        }
    }
}
