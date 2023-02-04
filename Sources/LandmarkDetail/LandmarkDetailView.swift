//
//  LandmarkDetailView.swift
//  
//
//  Created by Doan Le Thieu on 28/01/2023.
//

import ComposableArchitecture
import Models
import Styleguide
import SwiftUI

public struct LandmarkDetailView: View {

    private let store: StoreOf<LandmarkDetail>

    public init(store: StoreOf<LandmarkDetail>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            ScrollView {
                MapView(coordinates: viewStore.landmark.coordinates)
                    .frame(height: 300)

                ImageAsset(name: viewStore.landmark.imageName).image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250, height: 250)
                    .shadowedCicle()
                    .offset(y: -130)
                    .padding(.bottom, -130)

                VStack(alignment: .leading) {
                    HStack {
                        Text(viewStore.landmark.name)
                            .font(.title)

                        Button {
                            viewStore.send(.favoriteButtonTapped)
                        } label:{
                            Label("Toggle Favorite", systemImage: viewStore.landmark.isFavorite ?  "star.fill" : "star")
                                .labelStyle(.iconOnly)
                                .foregroundColor(viewStore.landmark.isFavorite ? .yellow : .gray)
                        }
                    }

                    HStack {
                        Text(viewStore.landmark.park)
                            .font(.subheadline)
                        Spacer()
                        Text(viewStore.landmark.state)
                            .font(.subheadline)
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                    Divider()

                    Text("About \(viewStore.landmark.name)")
                        .font(.title2)
                    Text(viewStore.landmark.description)
                }
                .padding()
            }
            .navigationTitle(viewStore.landmark.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct LandmarkDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkDetailView(
            store: Store(
                initialState: LandmarkDetail.State(landmark: .sampleData[0]),
                reducer: LandmarkDetail()
            )
        )
    }
}
