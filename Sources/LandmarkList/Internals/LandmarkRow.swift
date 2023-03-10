//
//  LandmarkRow.swift
//  
//
//  Created by Doan Le Thieu on 28/01/2023.
//

import LandmarkDetail
import Models
import Styleguide
import SwiftUI

struct LandmarkRow: View {

    var landmark: Landmark

    var body: some View {
        HStack {
            ImageAsset(name: landmark.imageName).image
                .resizable()
                .frame(width: 50, height: 50)
                .cornerRadius(5)

            VStack(alignment: .leading) {
                Text(landmark.name)
                    .bold()

                Text(landmark.park)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer()

            RenderIf(landmark.isFavorite) {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
        }
        .padding(.vertical, 4)
    }
}

struct LandmarkRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LandmarkRow(landmark: .sampleData[0])
            LandmarkRow(landmark: .sampleData[1])
        }
        .padding()
    }
}
