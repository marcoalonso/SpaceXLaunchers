//
//  UIButton+Extension.swift
//  SpaceXLaunches
//
//  Created by Marco Alonso Rodriguez on 27/05/25.
//

import UIKit

extension UIButton {
    func applyCircleStyle(iconName: String) {
        setImage(UIImage(systemName: iconName), for: .normal)
        self.tintColor = .white
        layer.cornerRadius = bounds.height / 2
        clipsToBounds = true
    }
}
