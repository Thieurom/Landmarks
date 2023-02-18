//
//  MacAppScene.swift
//  
//
//  Created by Doan Le Thieu on 17/02/2023.
//

import ComposableArchitecture
import LandmarkList
import SwiftUI

public struct MacAppScene: Scene {

    private let store: StoreOf<MacAppReducer>
    @ObservedObject var viewStore: ViewStore<MacAppReducer.SceneState, MacAppReducer.Action>

    public init(store: StoreOf<MacAppReducer>) {
        self.store = store
        self.viewStore = ViewStore(store.scope(state: MacAppReducer.SceneState.init(state:)))
    }

    public var body: some Scene {
        WindowGroup {
            LandmarkListView(
                store: store.scope(
                    state: \.landmarkList,
                    action: MacAppReducer.Action.landmarkList
                )
            )
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
        .commands {
            CommandMenu("Landmark") {
                Button(viewStore.favoriteCommandTitle) {
                    viewStore.send(.commands(.landmarkFavoriteToggled))
                }
                .keyboardShortcut("f", modifiers: [.shift, .option])
                .disabled(!viewStore.isFavoriteCommandEnabled)
            }
        }
    }
}
