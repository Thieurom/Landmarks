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
        public var landmarks: [Landmark]
        public var filter = FilterCategory.all
        public var showFavoritesOnly = false
        public var selectedLandmark: Identified<Landmark.ID, LandmarkDetail.State>?

        public var filteredLanmarks: IdentifiedArrayOf<Landmark> {
            .init(
                uniqueElements: landmarks
                    .filter {
                        (!showFavoritesOnly || $0.isFavorite)
                        && (filter == .all || $0.category.rawValue == filter.rawValue)
                    }
            )
        }

        public var title: String {
            let title = filter == .all ? "Landmarks" : filter.rawValue
            return showFavoritesOnly ? "Favorite \(title)" : title
        }

        public init(landmarks: [Landmark] = []) {
            self.landmarks = landmarks
        }
    }

    public enum Action {
        case filterSelected(FilterCategory)
        case favoriteToggled
        case setNavigation(selection: Int?)
        case landmark(LandmarkDetail.Action)
    }

    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case let .filterSelected(filter):
                state.filter = filter
                return .none
            case .favoriteToggled:
                state.showFavoritesOnly.toggle()
                return .none
            case let .setNavigation(selection: .some(id)):
                state.selectedLandmark = state.filteredLanmarks[id: id]
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
