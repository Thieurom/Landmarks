//
//  ProfileDetailView.swift
//  
//
//  Created by Doan Le Thieu on 04/02/2023.
//

import ComposableArchitecture
import Models
import Styleguide
import SwiftUI

public struct ProfileDetailView: View {

    private let store: StoreOf<ProfileDetail>

    public init(store: StoreOf<ProfileDetail>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            NavigationView {
                RenderIf(viewStore.isEditingProfile) {
                    ProfileEditorView(
                        profile: viewStore.binding(
                            get: \.profileInEditing,
                            send: ProfileDetail.Action.profileUpdated
                        )
                    )
                }.elseRender {
                    ProfileSummaryView(profile: viewStore.profile)
                }
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        RenderIf(viewStore.isEditingProfile) {
                            Button {
                                viewStore.send(.cancelButtonTapped)
                            } label: {
                                Text("Cancel")
                            }
                        }
                    }

                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        RenderIf(viewStore.isEditingProfile) {
                            Button {
                                viewStore.send(.doneButtonTapped)
                            } label: {
                                Text("Done")
                            }
                        }.elseRender {
                            Button {
                                viewStore.send(.editButtonTapped)
                            } label: {
                                Text("Edit")
                            }
                        }
                    }
                }
                .navigationTitle("")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct ProfileDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileDetailView(
            store: Store(
                initialState: ProfileDetail.State(profile: .default),
                reducer: ProfileDetail()
            )
        )
    }
}
