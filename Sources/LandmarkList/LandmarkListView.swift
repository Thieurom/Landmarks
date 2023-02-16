//
//  LandmarkListView.swift
//  
//
//  Created by Doan Le Thieu on 28/01/2023.
//

import ComposableArchitecture
import LandmarkDetail
import Models
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
                    Toggle(
                        isOn: viewStore.binding(
                            get: \.showFavoritesOnly,
                            send: LandmarkList.Action.favoriteToggled
                        )
                    ) {
                        Text("Favorites only")
                    }

                    ForEach(viewStore.filteredLanmarks) { landmark in
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
                                send: LandmarkList.Action.setNavigation
                            ),
                            label: {
                                LandmarkRow(landmark: landmark)
                            }
                        )
                    }
                }
                .navigationTitle(viewStore.title)
                .frame(minWidth: 300)
                .toolbar {
                    ToolbarItem {
                        Menu {
                            Picker(
                                "Category",
                                selection: viewStore.binding(
                                    get: \.filter,
                                    send: LandmarkList.Action.filterSelected
                                )
                            ) {
                                ForEach(FilterCategory.allCases) { category in
                                    Text(category.rawValue).tag(category)
                                }
                            }
                            .pickerStyle(.inline)

                            Toggle(
                                isOn: viewStore.binding(
                                    get: \.showFavoritesOnly,
                                    send: LandmarkList.Action.favoriteToggled
                                )
                            ) {
                                Label("Favorites only", systemImage: "star.fill")
                            }
                        } label: {
                            Label("Filter", systemImage: "slider.horizontal.3")
                        }
                    }
                }

                Text("Select a Landmark")
            }
        }
    }
}

struct LandmarkListView_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkListView(
            store: Store(
                initialState: LandmarkList.State(landmarks: Landmark.sampleData),
                reducer: LandmarkList()
            )
        )
    }
}
