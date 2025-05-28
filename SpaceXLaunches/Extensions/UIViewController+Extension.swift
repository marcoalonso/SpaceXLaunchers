//
//  UIViewController+Extension.swift
//  SpaceXLaunches
//
//  Created by Marco Alonso Rodriguez on 28/05/25.
//

import Foundation
import UIKit

extension UIViewController {
    private static var loaderTag = 999999

    func showLoader() {
        let loader = UIActivityIndicatorView(style: .large)
        loader.color = .gray
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.startAnimating()
        loader.tag = UIViewController.loaderTag

        view.addSubview(loader)

        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    func hideLoader() {
        if let loader = view.viewWithTag(UIViewController.loaderTag) as? UIActivityIndicatorView {
            loader.stopAnimating()
            loader.removeFromSuperview()
        }
    }
}
