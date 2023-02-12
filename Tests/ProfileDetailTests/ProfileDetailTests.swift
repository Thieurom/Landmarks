//
//  ProfileDetailTests.swift
//  
//
//  Created by Doan Le Thieu on 12/02/2023.
//

import ComposableArchitecture
import Models
import ProfileDetail
import XCTest

@MainActor
final class ProfileDetailTests: XCTestCase {

    func testEditProfile() async {
        let state = ProfileDetail.State(
            profile: Profile(
                username: "John",
                prefersNotifications: true,
                seasonalPhoto: .autumn,
                goalDate: Date(timeIntervalSinceReferenceDate: 12345678)
            )
        )

        let store = TestStore(
            initialState: state,
            reducer: ProfileDetail()
        )

        await store.send(.editButtonTapped) {
            $0.isEditingProfile = true
        }

        await store.send(.cancelButtonTapped) {
            $0.isEditingProfile = false
        }

        await store.send(.editButtonTapped) {
            $0.isEditingProfile = true
        }

        await store.send(.profileUpdated(
            Profile(
                username: "Peter",
                prefersNotifications: false,
                seasonalPhoto: .winter,
                goalDate: Date(timeIntervalSinceReferenceDate: 13000000)
            )
        )) {
            $0.profileInEditing = Profile(
                username: "Peter",
                prefersNotifications: false,
                seasonalPhoto: .winter,
                goalDate: Date(timeIntervalSinceReferenceDate: 13000000)
            )

            $0.profile = Profile(
                username: "John",
                prefersNotifications: true,
                seasonalPhoto: .autumn,
                goalDate: Date(timeIntervalSinceReferenceDate: 12345678)
            )
        }

        await store.send(.doneButtonTapped) {
            $0.isEditingProfile = false
            $0.profile = Profile(
                username: "Peter",
                prefersNotifications: false,
                seasonalPhoto: .winter,
                goalDate: Date(timeIntervalSinceReferenceDate: 13000000)
            )
        }
    }
}
