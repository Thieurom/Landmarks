//
//  AppView.swift
//  
//
//  Created by Doan Le Thieu on 23/01/2023.
//

import ComposableArchitecture
import LandmarkList
import SwiftUI

public struct AppView: View {

    public init() {}

    public var body: some View {
        LandmarkListView(
            store: Store(
                initialState: LandmarkList.State(),
                reducer: LandmarkList()
            )
        )
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
