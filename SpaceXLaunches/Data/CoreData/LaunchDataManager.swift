//
//  LaunchDataManager.swift
//  SpaceXLaunches
//
//  Created by Marco Alonso Rodriguez on 27/05/25.
//

import Foundation
import CoreData
import UIKit

final class LaunchDataManager {
    
    static let shared = LaunchDataManager()
    private let context: NSManagedObjectContext

    private init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Could not access AppDelegate")
        }
        self.context = appDelegate.persistentContainer.viewContext
    }

    func saveLaunches(_ launches: [LaunchModel]) {
        deleteAllLaunches()
        launches.forEach {
            _ = LaunchMapper.toEntity($0, context: context)
        }
        do {
            try context.save()
            print("Launches saved to Core Data.")
        } catch {
            print("Failed to save launches: \(error)")
        }
    }
    
    func fetchLaunches() -> [LaunchModel] {
        let request: NSFetchRequest<LaunchEntity> = LaunchEntity.fetchRequest()
        
        do {
            let entities = try context.fetch(request)
            return entities.compactMap { LaunchMapper.toModel($0) }
        } catch {
            print("Failed to fetch from Core Data: \(error)")
            return []
        }
    }

    private func deleteAllLaunches() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = LaunchEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
            print("All previous launches deleted.")
        } catch {
            print("Error deleting previous launches: \(error)")
        }
    }
}
