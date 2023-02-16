//
//  LandmarkDetail.swift
//  
//
//  Created by Doan Le Thieu on 28/01/2023.
//

import ComposableArchitecture
import MapKit
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
        case openInMapsButtonTapped
    }

    public init() {}

    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .favoriteButtonTapped:
            state.landmark.isFavorite.toggle()
            return .none
        case .openInMapsButtonTapped:
            let destination = MKMapItem(
                placemark: MKPlacemark(
                    coordinate: .init(
                        latitude: state.landmark.coordinates.latitude,
                        longitude: state.landmark.coordinates.longitude
                    )
                )
            )
            destination.name = state.landmark.name
            destination.openInMaps()
            return .none
        }
    }
}
