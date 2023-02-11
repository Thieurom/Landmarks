//
//  BadgesView.swift
//  
//
//  Created by Doan Le Thieu on 04/02/2023.
//

import SwiftUI

struct BadgesView: View {

    var body: some View {
        VStack(alignment: .leading) {
            Text("Completed Badges")
                .font(.headline)

            ScrollView(.horizontal) {
                HStack {
                    HikeBadge(name: "First Hike")
                    HikeBadge(name: "Earth Day")
                        .hueRotation(Angle(degrees: 90))
                    HikeBadge(name: "Tenth Hike")
                        .grayscale(0.5)
                        .hueRotation(Angle(degrees: 45))
                }
                .padding(.bottom)
            }
        }
        .padding(.horizontal)
    }
}
