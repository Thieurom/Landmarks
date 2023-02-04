//
//  Profile.swift
//  
//
//  Created by Doan Le Thieu on 04/02/2023.
//

import Foundation

public struct Profile: Equatable {

    public enum Season: String, CaseIterable, Identifiable {
        case spring = "🌷"
        case summer = "🌞"
        case autumn = "🍂"
        case winter = "☃️"

        public var id: String { rawValue }
    }

    public static let `default` = Profile(username: "g_kumar")

    public var username: String
    public var prefersNotifications = true
    public var seasonalPhoto = Season.winter
    public var goalDate = Date()

    public init(username: String, prefersNotifications: Bool = true, seasonalPhoto: Season = Season.winter, goalDate: Date = Date()) {
        self.username = username
        self.prefersNotifications = prefersNotifications
        self.seasonalPhoto = seasonalPhoto
        self.goalDate = goalDate
    }
}
