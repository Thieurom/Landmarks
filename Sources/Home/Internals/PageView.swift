//
//  PageView.swift
//  
//
//  Created by Doan Le Thieu on 03/02/2023.
//

import Models
import Styleguide
import SwiftUI

#if os(iOS)
struct PageView<Page: View>: View {

    var pages: [Page]
    @Binding var currentPage: Int?

    var body: some View {
        RenderIf(!pages.isEmpty) {
            ZStack(alignment: .bottomTrailing) {
                PageViewController(pages: pages, currentPage: $currentPage)
                PageControl(numberOfPages: pages.count, currentPage: $currentPage)
                    .frame(width: CGFloat(pages.count * 18))
                    .padding(.trailing)
            }
        }
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView(
            pages: Landmark.sampleData.map(FeatureView.init),
            currentPage: .constant(0)
        )
        .aspectRatio(3 / 2, contentMode: .fit)
    }
}
#endif
