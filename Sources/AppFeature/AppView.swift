//
//  AppView.swift
//  
//
//  Created by Doan Le Thieu on 23/01/2023.
//

import ComposableArchitecture
import Dependencies
import Home
import LandmarkList
import SwiftUI

public struct AppView: View {

    private let store: StoreOf<AppReducer>

    public init(store: StoreOf<AppReducer>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store, observe: \.selectedTab) { viewStore in
            TabView(selection: viewStore.binding(send: AppReducer.Action.tabSelected)) {
                HomeView(
                    store: store.scope(
                        state: \.home,
                        action: AppReducer.Action.home
                    )
                )
                .tabItem {
                    Label("Featured", systemImage: "star")
                }
                .tag(AppReducer.State.Tab.home)

                LandmarkListView(
                    store: store.scope(
                        state: \.landmarkList,
                        action: AppReducer.Action.landmarkList
                    )
                )
                .tabItem {
                    Label("List", systemImage: "list.bullet")
                }
                .tag(AppReducer.State.Tab.list)
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
                initialState: AppReducer.State(dataPath: "", dataBundle: .main),
                reducer: withDependencies {
                    $0.dataManager = .mock
                } operation: {
                    AppReducer()
                }
            )
        )
    }
}
