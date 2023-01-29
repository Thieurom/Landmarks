//
//  AppView.swift
//  
//
//  Created by Doan Le Thieu on 23/01/2023.
//

import ComposableArchitecture
import Dependencies
import LandmarkList
import SwiftUI

public struct AppView: View {

    private let store: StoreOf<AppFeature>

    public init(store: StoreOf<AppFeature>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store, observe: \.selectedTab) { viewStore in
            TabView(selection: viewStore.binding(send: AppFeature.Action.tabSelected)) {
                LandmarkListView(
                    store: store.scope(
                        state: \.landmarkList,
                        action: AppFeature.Action.landmarkList
                    )
                )
                .tabItem {
                    Label("List", systemImage: "list.bullet")
                }
                .tag(AppFeature.State.Tab.list)
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView(
            store: Store(
                initialState: AppFeature.State(dataPath: "", dataBundle: .main),
                reducer: withDependencies {
                    $0.dataManager = .mock
                } operation: {
                    AppFeature()
                }
            )
        )
    }
}
