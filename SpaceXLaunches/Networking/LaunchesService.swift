//
//  NetworkManager.swift
//  SpaceXLaunches
//
//  Created by Marco Alonso Rodriguez on 26/05/25.
//

import Foundation
import Combine
import Alamofire

final class LaunchesService: LaunchesServiceProtocol {

    func fetchLaunches() -> AnyPublisher<[LaunchModel], Error> {
        let url = "https://api.spacexdata.com/v3/launches/past"

        return Future<[LaunchModel], Error> { promise in
            AF.request(url)
                .validate()
                .responseDecodable(of: [LaunchModel].self) { response in
                    switch response.result {
                    case .success(let launches):
                        promise(.success(launches))
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
