//
//  CategoryRow.swift
//
//
//  Created by Doan Le Thieu on 29/01/2023.
//

import Models
import Styleguide
import SwiftUI

struct CategoryView<Destination>: View where Destination: View {

    var category: Landmark.Category
    var items: [Landmark]
    @Binding var selection: Int?
    var destination: Destination

    var body: some View {
        VStack(alignment: .leading) {
            Text(category.rawValue)
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(items) { landmark in
                        NavigationLink(
                            destination: destination,
                            tag: landmark.id,
                            selection: $selection,
                            label: {
                                CategoryItem(landmark: landmark)
                            }
                        )
                    }
                }
            }
            .frame(height: 185)
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var landmarks = Landmark.sampleData

    static var previews: some View {
        NavigationView {
            CategoryView(
                category: Landmark.Category.lakes,
                items: Array(landmarks.prefix(4)),
                selection: .constant(landmarks[0].id),
                destination: Text("Selected landmark")
            )
        }
    }
}
