//
//  SplashViewController.swift
//  SpaceXLaunches
//
//  Created by Marco Alonso Rodriguez on 26/05/25.
//

import Foundation
import UIKit
import Lottie

final class SplashViewController: UIViewController {
    
    private let animationView = LottieAnimationView(name: "rocket")

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupLottieAnimation()
        playAnimation()
    }

    private func setupBackground() {
        let backgroundImage = UIImageView(image: UIImage(named: "earth"))
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundImage)
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }

    private func setupLottieAnimation() {
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.contentMode = .scaleAspectFit
        view.addSubview(animationView)

        NSLayoutConstraint.activate([
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            animationView.widthAnchor.constraint(equalToConstant: 200),
            animationView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

    private func playAnimation() {
        animationView.play { [weak self] finished in
            if finished {
                // TODO: - Coordinator
                print("Lottie finished!")
            }
        }
    }
}
