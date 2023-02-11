//
//  ProfileSummaryView.swift
//  
//
//  Created by Doan Le Thieu on 11/02/2023.
//

import Models
import SwiftUI

struct ProfileSummaryView: View {

    var profile: Profile

    var body: some View {
        List {
            VStack(alignment: .leading, spacing: 10) {
                Text(profile.username)
                    .bold()
                    .font(.title)
                    .padding(.bottom, 10)

                Text("Notifications: \(profile.prefersNotifications ? "On": "Off" )")
                Text("Seasonal Photos: \(profile.seasonalPhoto.rawValue)")
                Text("Goal Date: ") + Text(profile.goalDate, style: .date)
            }
            .padding(.horizontal)

            BadgesView()
        }
        .listStyle(.plain)
    }
}

struct ProfileSummary_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSummaryView(profile: Profile.default)
    }
}


