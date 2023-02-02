//
//  CategoryItem.swift
//
//
//  Created by Doan Le Thieu on 01/02/2023.
//

import Assets
import Models
import SwiftUI

struct CategoryItem: View {

    var landmark: Landmark

    var body: some View {
        VStack(alignment: .leading) {
            ImageAsset(name: landmark.imageName)
                .image
                .renderingMode(.original)
                .resizable()
                .frame(width: 155, height: 155)
                .cornerRadius(5)

            Text(landmark.name)
                .foregroundColor(.primary)
                .font(.caption)
        }
        .padding(.leading, 15)
    }
}

struct CategoryItem_Previews: PreviewProvider {
    static var previews: some View {
        CategoryItem(landmark: .sampleData[0])
    }
}
