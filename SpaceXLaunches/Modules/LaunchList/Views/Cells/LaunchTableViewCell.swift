//
//  LaunchTableViewCell.swift
//  SpaceXLaunches
//
//  Created by Marco Alonso Rodriguez on 26/05/25.
//

import UIKit

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

    func configure(with launch: LaunchModel) {
        missionNameLabel.text = launch.missionName
        siteNameLabel.text = launch.launchSite.siteName
        missionDateLabel.text = launch.formattedDate
        
        if let urlString = launch.links.missionPatch, let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data {
                    DispatchQueue.main.async {
                        self.missionImageView.image = UIImage(data: data)
                    }
                }
            }.resume()
        } else {
            missionImageView.image = UIImage(named: "placeholder_rocket")
        }
    }
}
