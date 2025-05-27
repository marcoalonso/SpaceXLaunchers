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
        let launchListVC = LaunchListViewController()
        navigationController.setViewControllers([launchListVC], animated: true)
    }
}
