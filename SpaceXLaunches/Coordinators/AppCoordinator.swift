//
//  AppCoordinator.swift
//  SpaceXLaunches
//
//  Created by Marco Alonso Rodriguez on 26/05/25.
//

import Foundation
import UIKit
import FirebaseAuth
import SafariServices

protocol LaunchDetailCoordinatorDelegate: AnyObject {
    func didTapYouTubeVideo(videoId: String)
    func didTapSafariLink(url: URL)
}

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
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(userDidLogout),
                                               name: .userDidLogout,
                                               object: nil)
    }
    
    @objc private func userDidLogout() {
        showLogin()
    }

    func start() {
        let splashVC = SplashViewController()
        splashVC.onAnimationCompleted = { [weak self] in
            self?.checkUserSession()
        }

        navigationController.setViewControllers([splashVC], animated: false)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    private func checkUserSession() {
        if Auth.auth().currentUser != nil {
            showLaunchList()
        } else {
            showLogin()
        }
    }

    private func showLogin() {
        let loginVM = LoginViewModel()
        loginVM.onLoginSuccess = { [weak self] in
            self?.showLaunchList()
        }

        loginVM.onRegisterTap = { [weak self] in
            self?.showRegister()
        }

        let loginVC = LoginViewController(viewModel: loginVM)
        navigationController.setViewControllers([loginVC], animated: true)
    }

    private func showRegister() {
        let registerVM = RegisterViewModel()
        registerVM.onRegisterSuccess = { [weak self] in
            self?.showLaunchList()
        }

        registerVM.onGoBackToLogin = { [weak self] in
            self?.navigationController.popViewController(animated: true)
        }

        let registerVC = RegisterViewController(viewModel: registerVM)
        navigationController.pushViewController(registerVC, animated: true)
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
        let detailVM = LaunchDetailViewModel(launch: launch)
        let detailVC = LaunchDetailViewController(viewModel: detailVM)
        detailVC.coordinatorDelegate = self
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationController.topViewController?.navigationItem.backBarButtonItem = backItem
        
        navigationController.pushViewController(detailVC, animated: true)
    }
    
    func showYouTubeVideo(with videoId: String) {
        let youtubeVC = YouTubePlayerViewController(videoId: videoId)
        navigationController.pushViewController(youtubeVC, animated: true)
    }
}

extension AppCoordinator: LaunchDetailCoordinatorDelegate {
    func didTapYouTubeVideo(videoId: String) {
        showYouTubeVideo(with: videoId)
    }
    
    func didTapSafariLink(url: URL) {
        let safariVC = SFSafariViewController(url: url)
        navigationController.present(safariVC, animated: true)
    }
}

extension Notification.Name {
    static let userDidLogout = Notification.Name("userDidLogout")
}
