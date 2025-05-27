//
//  LaunchDetailViewModel.swift
//  SpaceXLaunches
//
//  Created by Marco Alonso Rodriguez on 27/05/25.
//

import Foundation

final class LaunchDetailViewModel {

    let missionName: String
    let siteName: String
    let date: String
    let rocketName: String
    let rocketType: String
    let details: String?
    let flickrImages: [String]
    let youtubeURL: URL?
    let infoURL: URL?

    init(launch: LaunchModel) {
        self.missionName = launch.missionName
        self.siteName = launch.launchSite.siteName
        self.date = launch.formattedDate
        self.rocketName = launch.rocket.rocketName
        self.rocketType = launch.rocket.rocketType
        self.details = launch.details
        self.flickrImages = launch.links.flickrImages
        self.youtubeURL = URL(string: launch.links.videoLink ?? "")
        self.infoURL = URL(string: launch.links.wikipedia ?? launch.links.articleLink ?? "")
    }
}
