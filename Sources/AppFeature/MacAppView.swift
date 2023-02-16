//
//  MacAppView.swift
//  
//
//  Created by Doan Le Thieu on 14/02/2023.
//

import ComposableArchitecture
import Dependencies
import LandmarkList
import SwiftUI

#if os(macOS)
public struct MacAppView: View {

    private let store: StoreOf<MacAppReducer>

    public init(store: StoreOf<MacAppReducer>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
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
    }
}

struct MacAppView_Previews: PreviewProvider {
    static var previews: some View {
        MacAppView(
            store: Store(
                initialState: MacAppReducer.State(dataPath: "", dataBundle: .main),
                reducer: MacAppReducer()
            ) {
                $0.dataManager = .mock
            }
        )
    }
}#endif
