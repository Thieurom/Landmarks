//
//  LandmarkListView.swift
//  
//
//  Created by Doan Le Thieu on 28/01/2023.
//

import ComposableArchitecture
import LandmarkDetail
import SwiftUI

public struct LandmarkListView: View {

    private let store: StoreOf<LandmarkList>

    public init(store: StoreOf<LandmarkList>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            NavigationView {
                List {
                    ForEach(viewStore.landmarks) { landmark in
                        NavigationLink(
                            destination: IfLetStore(
                                store.scope(
                                    state: \.selectedLandmark?.value,
                                    action: LandmarkList.Action.landmark
                                )
                            ) {
                                LandmarkDetailView(store: $0)
                            },
                            tag: landmark.id,
                            selection: viewStore.binding(
                                get: \.selectedLandmark?.id,
                                send: LandmarkList.Action.setNavigation(selection:)
                            ),
                            label: {
                                LandmarkRow(landmark: landmark)
                            }
                        )
                    }
                }
                .navigationTitle("Landmarks")
            }
        }
    }
}

struct LandmarkListView_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkListView(
            store: Store(
                initialState: LandmarkList.State(),
                reducer: LandmarkList()
            )
        )
    }
}
