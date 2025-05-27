//
//  AppCoordinator.swift
//  SpaceXLaunches
//
//  Created by Marco Alonso Rodriguez on 26/05/25.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}

final class AppCoordinator: Coordinator {

    var window: UIWindow
    var navigationController: UINavigationController

    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
    }

    func start() {
        let splashVC = SplashViewController()
        splashVC.onAnimationCompleted = { [weak self] in
            self?.showLaunchList()
        }

        navigationController.setViewControllers([splashVC], animated: false)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    private func showLaunchList() {
        let service = LaunchesService()
        let viewModel = LaunchListViewModel(service: service)
        
        viewModel.onLaunchSelected = { [weak self] launch in
            self?.showLaunchDetail(for: launch)
        }

        let launchListVC = LaunchListViewController(viewModel: viewModel)
        navigationController.setViewControllers([launchListVC], animated: true)
    }

    private func showLaunchDetail(for launch: LaunchModel) {
        let detailViewModel = LaunchDetailViewModel(launch: launch)
        let detailVC = LaunchDetailViewController(viewModel: detailViewModel)
        navigationController.pushViewController(detailVC, animated: true)
    }
}
