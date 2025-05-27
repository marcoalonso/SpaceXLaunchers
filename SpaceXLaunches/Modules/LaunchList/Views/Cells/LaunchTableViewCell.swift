//
//  LaunchTableViewCell.swift
//  SpaceXLaunches
//
//  Created by Marco Alonso Rodriguez on 26/05/25.
//

import UIKit
import Kingfisher

class LaunchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var missionImageView: UIImageView!
    @IBOutlet weak var missionNameLabel: UILabel!
    @IBOutlet weak var siteNameLabel: UILabel!
    @IBOutlet weak var missionDateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        missionImageView.contentMode = .scaleAspectFit
        missionImageView.layer.cornerRadius = 12
        missionImageView.clipsToBounds = true
        
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 12
        
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.3
        containerView.layer.shadowOffset = CGSize(width: 0, height: 5)
        containerView.layer.shadowRadius = 9
        
        containerView.layer.masksToBounds = false
        contentView.backgroundColor = .clear
    }
    
    /// Configures the cell with launch data.
    ///
    /// Sets the mission name, site name, launch date, and loads the mission patch image using Kingfisher.
    /// Applies downsampling and corner radius processing for better performance and appearance.
    ///
    /// - Parameter launch: A `LaunchModel` instance containing the data to display.
    func configure(with launch: LaunchModel) {
        missionNameLabel.text = launch.missionName
        missionDateLabel.textColor = .textPrimary
        siteNameLabel.text = launch.launchSite.siteName
        siteNameLabel.textColor = .textSecondary
        missionDateLabel.text = launch.formattedDate
        missionDateLabel.textColor = .textSecondary
        
        if let urlString = launch.links.missionPatch, let url = URL(string: urlString) {
            let processor = DownsamplingImageProcessor(size: missionImageView.bounds.size)
            |> RoundCornerImageProcessor(cornerRadius: 8)
            
            missionImageView.kf.indicatorType = .activity
            missionImageView.kf.setImage(
                with: url,
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(0.2)),
                    .cacheOriginalImage
                ])
        } else {
            missionImageView.image = UIImage(named: "placeholder_rocket")
        }
    }
}
