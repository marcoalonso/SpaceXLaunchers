//
//  LaunchMapper.swift
//  SpaceXLaunches
//
//  Created by Marco Alonso Rodriguez on 27/05/25.
//

import Foundation
import CoreData

struct LaunchMapper {
    
    static func toEntity(_ model: LaunchModel, context: NSManagedObjectContext) -> LaunchEntity {
        let entity = LaunchEntity(context: context)
        entity.id = Int64(model.flightNumber)
        entity.missionName = model.missionName
        entity.launchDateUTC = model.launchDateUTC
        entity.siteName = model.launchSite.siteName
        entity.rocketName = model.rocket.rocketName
        entity.rocketType = model.rocket.rocketType
        entity.details = model.details ?? ""
        entity.articleLink = model.links.articleLink ?? ""
        entity.wikipediaLink = model.links.wikipedia ?? ""
        entity.youtubeId = model.links.youtubeId ?? ""
        entity.missionPatch = model.links.missionPatch ?? ""

        if let imageData = try? JSONEncoder().encode(model.links.flickrImages),
           let jsonString = String(data: imageData, encoding: .utf8) {
            entity.imageURLs = jsonString
        } else {
            entity.imageURLs = "[]"
        }

        return entity
    }
    
    static func toModel(_ entity: LaunchEntity) -> LaunchModel? {
        guard let missionName = entity.missionName,
              let launchDateUTC = entity.launchDateUTC,
              let siteName = entity.siteName,
              let rocketName = entity.rocketName,
              let rocketType = entity.rocketType,
              let articleLink = entity.articleLink,
              let wikipediaLink = entity.wikipediaLink,
              let youtubeId = entity.youtubeId,
              let imageJSONString = entity.imageURLs else {
            return nil
        }

        let flickrImages: [String]
        if let data = imageJSONString.data(using: .utf8),
           let decoded = try? JSONDecoder().decode([String].self, from: data) {
            flickrImages = decoded
        } else {
            flickrImages = []
        }

        return LaunchModel(
            flightNumber: Int(entity.id),
            missionName: missionName,
            launchDateUTC: launchDateUTC,
            launchSite: .init(siteName: siteName),
            rocket: .init(rocketName: rocketName, rocketType: rocketType),
            links: .init(
                missionPatch: entity.missionPatch,
                articleLink: articleLink,
                wikipedia: wikipediaLink,
                videoLink: nil,
                youtubeId: youtubeId,
                flickrImages: flickrImages
            ),
            details: entity.details
        )
    }
}
