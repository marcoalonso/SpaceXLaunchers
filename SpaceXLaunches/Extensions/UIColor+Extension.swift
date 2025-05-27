//
//  UIColor+Extension.swift
//  SpaceXLaunches
//
//  Created by Marco Alonso Rodriguez on 26/05/25.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let r = CGFloat((rgb >> 16) & 0xFF) / 255
        let g = CGFloat((rgb >> 8) & 0xFF) / 255
        let b = CGFloat(rgb & 0xFF) / 255

        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }

    static let primary = UIColor(hex: "#1E90FF")
    static let secondary = UIColor(hex: "#00ADB5")
    static let success = UIColor(hex: "#21BF73")
    static let error = UIColor(hex: "#FF5E5E")
    static let background = UIColor(hex: "#0B0C10")
    static let surface = UIColor(hex: "#1F1F1F")
    static let textPrimary = UIColor(hex: "#EAEAEA")
    static let textSecondary = UIColor(hex: "#A3A3A3")
}
