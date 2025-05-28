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

    private let upperAnimationView = LottieAnimationView(name: "moon")
    private let rocketAnimationView = LottieAnimationView(name: "rocket")

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupLottieAnimations()
        playAnimations()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.onAnimationCompleted?()
        }
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

    private func setupLottieAnimations() {
        upperAnimationView.translatesAutoresizingMaskIntoConstraints = false
        upperAnimationView.contentMode = .scaleAspectFit
        view.addSubview(upperAnimationView)

        rocketAnimationView.translatesAutoresizingMaskIntoConstraints = false
        rocketAnimationView.contentMode = .scaleAspectFit
        view.addSubview(rocketAnimationView)

        NSLayoutConstraint.activate([
            upperAnimationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            upperAnimationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            upperAnimationView.widthAnchor.constraint(equalToConstant: 200),
            upperAnimationView.heightAnchor.constraint(equalToConstant: 200),

            rocketAnimationView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            rocketAnimationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rocketAnimationView.widthAnchor.constraint(equalToConstant: 300),
            rocketAnimationView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }

    private func playAnimations() {
        upperAnimationView.loopMode = .loop
        upperAnimationView.play()

        rocketAnimationView.play { [weak self] finished in
            if finished {
                self?.onAnimationCompleted?()
            }
        }
    }

    var onAnimationCompleted: (() -> Void)?
}
