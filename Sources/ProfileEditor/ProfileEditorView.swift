//
//  ProfileEditorView.swift
//  
//
//  Created by Doan Le Thieu on 05/02/2023.
//

import ComposableArchitecture
import Models
import SwiftUI

public struct ProfileEditorView: View {

    private let store: StoreOf<ProfileEditor>

    public init(store: StoreOf<ProfileEditor>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            List {
                HStack {
                    Text("Username").bold()
                    Divider()
                    TextField(
                        "Username",
                        text: viewStore.binding(
                            get: \.profile.username,
                            send: ProfileEditor.Action.usernameChanged
                        )
                    )
                }

                Toggle(
                    isOn: viewStore.binding(
                        get: \.profile.prefersNotifications,
                        send: ProfileEditor.Action.notificationEnabled
                    )
                ) {
                    Text("Enable Notifications").bold()
                }

                VStack(alignment: .leading, spacing: 20) {
                    Text("Seasonal Photo").bold()

                    Picker(
                        "Seasonal Photo",
                        selection: viewStore.binding(
                            get: \.profile.seasonalPhoto,
                            send: ProfileEditor.Action.seasonalPhotoUpdated
                        )
                    ) {
                        ForEach(Profile.Season.allCases) { season in
                            Text(season.rawValue).tag(season)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                DatePicker(
                    selection: viewStore.binding(
                        get: \.profile.goalDate,
                        send: ProfileEditor.Action.goalDateUpdated
                    ),
                    in: viewStore.dateRange,
                    displayedComponents: .date
                ) {
                    Text("Goal Date").bold()
                }
            }
        }
    }
}

struct ProfileEditor_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditorView(
            store: .init(
                initialState: ProfileEditor.State(profile: .default),
                reducer: ProfileEditor()
            )
        )
    }
}
