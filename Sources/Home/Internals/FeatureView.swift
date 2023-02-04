//
//  FeatureView.swift
//  
//
//  Created by Doan Le Thieu on 03/02/2023.
//

import Models
import Styleguide
import SwiftUI

struct FeatureView: View {

    var landmark: Landmark

    var body: some View {
        ImageAsset(name: landmark.imageName + "_feature")
            .image
            .resizable()
            .aspectRatio(3 / 2, contentMode: .fit)
            .overlay {
                TextOverlay(title: landmark.name, subtitle: landmark.park)
            }
    }
}

struct TextOverlay: View {

    var title: String
    var subtitle: String

    var gradient: LinearGradient {
        .linearGradient(
            Gradient(colors: [.black.opacity(0.6), .black.opacity(0)]),
            startPoint: .bottom,
            endPoint: .center)
    }

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            gradient
            VStack(alignment: .leading) {
                Text(title)
                    .font(.title)
                    .bold()
                Text(subtitle)
            }
            .padding()
        }
        .foregroundColor(.white)
    }
}

struct FeatureView_Previews: PreviewProvider {
    static var previews: some View {
        FeatureView(landmark: .sampleData[0])
    }
}
