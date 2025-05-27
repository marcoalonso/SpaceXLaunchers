//
//  LaunchDetailViewController.swift
//  SpaceXLaunches
//
//  Created by Marco Alonso Rodriguez on 27/05/25.
//

import UIKit
import SafariServices
import Kingfisher

class LaunchDetailViewController: UIViewController {
    
    @IBOutlet weak var siteLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var rocketNameLabel: UILabel!
    @IBOutlet weak var rocketTypeLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    private let viewModel: LaunchDetailViewModel
    
    init(viewModel: LaunchDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "LaunchDetailViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Use init(viewModel:) instead")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    private func setupUI() {
        title = viewModel.missionName
        titleLabel.text = viewModel.missionName
        siteLabel.text = "Site: \(viewModel.siteName)"
        dateLabel.text = "Date: \(viewModel.date)"
        rocketNameLabel.text = "Rocket name: \(viewModel.rocketName)"
        rocketTypeLabel.text = "Rocket type: \(viewModel.rocketType)"
        descriptionLabel.text = viewModel.details
        
        // setupImageCarousel()
    }

}
