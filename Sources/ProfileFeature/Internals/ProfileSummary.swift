//
//  ProfileSummary.swift
//  
//
//  Created by Doan Le Thieu on 04/02/2023.
//

import Models
import SwiftUI

struct ProfileSummary: View {

    var profile: Profile

    var body: some View {
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
    }
}

struct ProfileSummary_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSummary(profile: Profile.default)
    }
}

