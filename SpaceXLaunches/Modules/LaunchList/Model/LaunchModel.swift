//
//  LaunchModel.swift
//  SpaceXLaunches
//
//  Created by Marco Alonso Rodriguez on 26/05/25.
//

import Foundation

struct LaunchModel: Decodable {
    let flightNumber: Int
    let missionName: String
    let launchDateUTC: String
    let launchSite: LaunchSite
    let rocket: Rocket
    let links: LaunchLinks
    let details: String?

    enum CodingKeys: String, CodingKey {
        case flightNumber = "flight_number"
        case missionName = "mission_name"
        case launchDateUTC = "launch_date_utc"
        case launchSite = "launch_site"
        case rocket
        case links
        case details
    }

    struct LaunchSite: Decodable {
        let siteName: String

        enum CodingKeys: String, CodingKey {
            case siteName = "site_name"
        }
    }

    struct Rocket: Decodable {
        let rocketName: String
        let rocketType: String

        enum CodingKeys: String, CodingKey {
            case rocketName = "rocket_name"
            case rocketType = "rocket_type"
        }
    }

    struct LaunchLinks: Decodable {
        let missionPatch: String?
        let articleLink: String?
        let wikipedia: String?
        let videoLink: String?
        let youtubeId: String?
        let flickrImages: [String]

        enum CodingKeys: String, CodingKey {
            case missionPatch = "mission_patch"
            case articleLink = "article_link"
            case wikipedia
            case videoLink = "video_link"
            case youtubeId = "youtube_id"
            case flickrImages = "flickr_images"
        }
    }
}

extension LaunchModel {
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)

        guard let date = formatter.date(from: launchDateUTC) else { return "N/A" }

        let displayFormatter = DateFormatter()
        displayFormatter.dateStyle = .full
        displayFormatter.timeStyle = .none
        displayFormatter.locale = Locale(identifier: "es_MX")
        return displayFormatter.string(from: date)
    }
}
