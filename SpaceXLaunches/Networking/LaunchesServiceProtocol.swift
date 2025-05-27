//
//  LaunchesServiceProtocol.swift
//  SpaceXLaunches
//
//  Created by Marco Alonso Rodriguez on 26/05/25.
//

import Foundation
import Combine

protocol LaunchesServiceProtocol {
    func fetchLaunches() -> AnyPublisher<[LaunchModel], Error>
}
