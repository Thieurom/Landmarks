//
//  Home.swift
//  
//
//  Created by Doan Le Thieu on 29/01/2023.
//

import ComposableArchitecture
import LandmarkDetail
import Models
import ProfileFeature

public struct Home: ReducerProtocol {

    public struct State: Equatable {
        public var landmarks: [Landmark] {
            willSet {
                if landmarks != newValue {
                    featureIndex = newValue.isEmpty ? nil : 0
                }
            }
            didSet {
                if let landmark = landmarks.first(where: { $0.id == selectedLandmark?.landmark.id }) {
                    selectedLandmark = LandmarkDetail.State(landmark: landmark)
                }
            }
        }

        public var featureIndex: Int?
        public var selectedLandmark: LandmarkDetail.State?
        public var profile: ProfileFeature.State?
        public var isSheetPresented = false

        public init(landmarks: [Landmark] = []) {
            self.landmarks = landmarks
            self.featureIndex = landmarks.isEmpty ? nil : 0
        }

        public var categories: [Landmark.Category: [Landmark]] {
            Dictionary(
                grouping: landmarks,
                by: { $0.category }
            )
        }

        public var features: [Landmark] {
            landmarks.filter { $0.isFeatured }
        }
    }

    public enum Action {
        case featureIndexChanged(Int?)
        case setNavigation(selection: Int?)
        case setSheet(isPresented: Bool)
        case landmark(LandmarkDetail.Action)
        case profile(ProfileFeature.Action)
    }

    public init() {}

    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case let .featureIndexChanged(index):
                state.featureIndex = index
                return .none
            case let .setNavigation(selection: .some(id)):
                state.selectedLandmark = state.landmarks
                    .first(where: { $0.id == id })
                    .map(LandmarkDetail.State.init)
                return .none
            case .setNavigation(selection: .none):
                state.selectedLandmark = nil
                return .none
            case .setSheet(isPresented: true):
                state.isSheetPresented = true
                state.profile = .init()
                return .none
            case .setSheet(isPresented: false):
                state.isSheetPresented = false
                state.profile = nil
                return .none
            case .landmark(.favoriteButtonTapped):
                let updatedLandmarks = state.landmarks.map { landmark in
                    var copy = landmark
                    if let selectedLandmark = state.selectedLandmark?.landmark,
                       copy.id == selectedLandmark.id {
                        copy.isFavorite = selectedLandmark.isFavorite
                    }
                    return copy
                }
                state.landmarks = updatedLandmarks
                return .none
            case .landmark:
                return .none
            case .profile:
                return .none
            }
        }
        .ifLet(\.selectedLandmark, action: /Action.landmark) {
            LandmarkDetail()
        }
        .ifLet(\.profile, action: /Action.profile) {
            ProfileFeature()
        }
    }
}
