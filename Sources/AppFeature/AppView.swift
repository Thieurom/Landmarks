//
//  AppView.swift
//  
//
//  Created by Doan Le Thieu on 23/01/2023.
//

import ComposableArchitecture
import LandmarkDetail
import SwiftUI

public struct AppView: View {

    public init() {}

    public var body: some View {
        LandmarkDetailView(
            store: Store(
                initialState: LandmarkDetail.State(landmark: .example),
                reducer: LandmarkDetail()
            )
        )
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
