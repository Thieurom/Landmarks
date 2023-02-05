//
//  ProfileView.swift
//  
//
//  Created by Doan Le Thieu on 04/02/2023.
//

import ComposableArchitecture
import Models
import Styleguide
import SwiftUI

public struct ProfileView: View {

    private let store: StoreOf<ProfileFeature>

    public init(store: StoreOf<ProfileFeature>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            NavigationView {
                List {
                    ProfileSummary(profile: viewStore.profile)
                    BadgesView()
                }
                .listStyle(.plain)
                .navigationTitle("")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    Button {
                        viewStore.send(.editButtonTapped)
                    } label: {
                        Text("Edit")
                    }
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(
            store: Store(
                initialState: ProfileFeature.State(),
                reducer: ProfileFeature()
            )
        )
    }
}
