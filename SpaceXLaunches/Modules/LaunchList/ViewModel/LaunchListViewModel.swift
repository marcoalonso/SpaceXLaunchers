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
    
    private var allLaunches: [LaunchModel] = []
    
    var onLaunchSelected: ((LaunchModel) -> Void)?
    let coreDataManager = LaunchDataManager.shared

    private let service: LaunchesServiceProtocol
    private var cancellables = Set<AnyCancellable>()

    init(service: LaunchesServiceProtocol) {
        self.service = service
    }

    func fetchLaunches() {
        isLoading = true
        errorMessage = nil

        let localLaunches = coreDataManager.fetchLaunches()
        
        if !localLaunches.isEmpty {
            self.allLaunches = localLaunches
            self.launches = localLaunches
            isLoading = false
            return
        }

        service.fetchLaunches()
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] launches in
                self?.allLaunches = launches
                self?.launches = launches
                self?.coreDataManager.saveLaunches(launches)
            }
            .store(in: &cancellables)
    }
    
    func selectLaunch(_ launch: LaunchModel) {
        onLaunchSelected?(launch)
    }

    func filterLaunches(query: String) {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmed.isEmpty else {
            launches = allLaunches
            return
        }
        
        launches = allLaunches.filter {
            $0.missionName.localizedCaseInsensitiveContains(trimmed) ||
            $0.launchSite.siteName.localizedCaseInsensitiveContains(trimmed)
        }
    }
}
