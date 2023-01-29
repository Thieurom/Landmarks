//
//  LandmarksApp.swift
//  Landmarks
//
//  Created by Doan Le Thieu on 23/01/2023.
//

import AppFeature
import ComposableArchitecture
import SwiftUI

@main
struct LandmarksApp: App {
    var body: some Scene {
        WindowGroup {
            AppView(
                store: Store(
                    initialState: AppFeature.State(dataPath: "landmarkData.json", dataBundle: .main),
                    reducer: AppFeature()
                )
            )
        }
    }
}
