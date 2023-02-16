//
//  MacLandmarksApp.swift
//  MacLandmarks
//
//  Created by Doan Le Thieu on 14/02/2023.
//

import AppFeature
import ComposableArchitecture
import SwiftUI

@main
struct MacLandmarksApp: App {
    var body: some Scene {
        WindowGroup {
            MacAppView(
                store: Store(
                    initialState: MacAppReducer.State(dataPath: "landmarkData.json", dataBundle: .main),
                    reducer: MacAppReducer()
                )
            )
        }
    }
}
