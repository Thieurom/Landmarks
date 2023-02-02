//
//  HomeView.swift
//  
//
//  Created by Doan Le Thieu on 29/01/2023.
//

import Assets
import ComposableArchitecture
import LandmarkDetail
import Models
import SwiftUI

public struct HomeView: View {

    private let store: StoreOf<Home>

    public init(store: StoreOf<Home>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            NavigationView {
                List {
                    ForEach(viewStore.categories.keys.sorted { $0.rawValue < $1.rawValue }, id: \.self) { category in
                        CategoryView(
                            category: category,
                            items: viewStore.categories[category]!,
                            selection: viewStore.binding(
                                get: \.selectedLandmark?.landmark.id,
                                send: Home.Action.setNavigation(selection:)
                            ),
                            destination: IfLetStore(
                                store.scope(
                                    state: \.selectedLandmark,
                                    action: Home.Action.landmark
                                )
                            ) {
                                LandmarkDetailView(store: $0)
                            }
                        )
                    }
                    .listRowInsets(EdgeInsets())
                }
                .listStyle(.inset)
                .navigationTitle("Featured")
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(
            store: Store(
                initialState: Home.State(landmarks: Landmark.sampleData),
                reducer: Home()
            )
        )
    }
}
