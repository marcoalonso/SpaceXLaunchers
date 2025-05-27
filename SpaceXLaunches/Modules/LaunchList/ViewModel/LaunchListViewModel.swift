//
//  LaunchListViewModel.swift
//  SpaceXLaunches
//
//  Created by Marco Alonso Rodriguez on 26/05/25.
//

import Foundation
import Combine

final class LaunchListViewModel {

    @Published private(set) var launches: [LaunchModel] = []
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?

    private let service: LaunchesServiceProtocol
    private var cancellables = Set<AnyCancellable>()

    init(service: LaunchesServiceProtocol) {
        self.service = service
    }

    func fetchLaunches() {
        isLoading = true
        errorMessage = nil

        service.fetchLaunches()
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] launches in
                self?.launches = launches
            }
            .store(in: &cancellables)
    }
}
