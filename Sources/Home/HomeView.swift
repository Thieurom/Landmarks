//
//  HomeView.swift
//  
//
//  Created by Doan Le Thieu on 29/01/2023.
//

import ComposableArchitecture
import LandmarkDetail
import Models
import ProfileDetail
import Styleguide
import SwiftUI

#if os(iOS)
public struct HomeView: View {

    private let store: StoreOf<Home>

    public init(store: StoreOf<Home>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            NavigationView {
                List {
                    PageView(
                        pages: viewStore.features.map(FeatureView.init),
                        currentPage: viewStore.binding(
                            get: \.featureIndex,
                            send: Home.Action.featureIndexChanged
                        )
                    )
                    .aspectRatio(3 / 2, contentMode: .fit)
                    .listRowInsets(EdgeInsets())

                    ForEach(viewStore.categories.keys.sorted { $0.rawValue < $1.rawValue }, id: \.self) { category in
                        CategoryView(
                            category: category,
                            items: viewStore.categories[category]!,
                            selection: viewStore.binding(
                                get: \.selectedLandmark?.landmark.id,
                                send: Home.Action.setNavigation
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
                .toolbar {
                    Button {
                        viewStore.send(.setSheet(isPresented: true))
                    } label: {
                        Label("User Profile", systemImage: "person.crop.circle")
                    }
                    .id(UUID()) // Hack to fix sheet is presented only once
                }
                .sheet(isPresented: viewStore.binding(
                    get: \.isSheetPresented,
                    send: Home.Action.setSheet
                )) {
                    IfLetStore(
                        self.store.scope(
                            state: \.profileDetail,
                            action: Home.Action.profileDetail
                        )
                    ) {
                        ProfileDetailView(store: $0)
                    }
                }
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
#endif
