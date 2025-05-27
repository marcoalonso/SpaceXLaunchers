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
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var rocketNameLabel: UILabel!
    @IBOutlet weak var rocketTypeLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var youtubeCircleButton: UIButton!
    @IBOutlet weak var safariCircleButton: UIButton!
    
    @IBOutlet weak var collectionHeightConstraint: NSLayoutConstraint!
    weak var coordinatorDelegate: LaunchDetailCoordinatorDelegate?
    
    private let viewModel: LaunchDetailViewModel
    
    private var images: [String] = []
    
    init(viewModel: LaunchDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "LaunchDetailViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Use init(viewModel:) instead")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        configurePageControl()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: collectionView.bounds.width, height: 150)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.tintColor = .black
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.register(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.itemSize = collectionView.frame.size
        collectionView.collectionViewLayout = layout

        images = viewModel.flickrImages
        let shouldHideCarousel = images.isEmpty
        collectionHeightConstraint.constant = shouldHideCarousel ? 0 : 190
        collectionView.isHidden = shouldHideCarousel
        pageControl.isHidden = shouldHideCarousel
    }

    private func configurePageControl() {
        pageControl.numberOfPages = images.count
        pageControl.currentPage = 0
        pageControl.hidesForSinglePage = true
    }
    
    private func setupUI() {
        title = viewModel.missionName
        siteLabel.text = "Site: \(viewModel.siteName)"
        dateLabel.text = "Date: \(viewModel.date)"
        rocketNameLabel.text = "Rocket name: \(viewModel.rocketName)"
        rocketTypeLabel.text = "Rocket type: \(viewModel.rocketType)"
        descriptionLabel.text = viewModel.details
        
        let infoLabels: [UILabel] = [
            siteLabel,
            dateLabel,
            rocketNameLabel,
            rocketTypeLabel,
            descriptionLabel
        ]

        infoLabels.forEach { $0.textColor = .textPrimary }

        youtubeCircleButton.applyCircleStyle(iconName: "play.fill")
        safariCircleButton.applyCircleStyle(iconName: "info.circle.fill")
        view.backgroundColor = UIColor.systemGroupedBackground
        collectionView.backgroundColor = view.backgroundColor
        
        self.images = viewModel.flickrImages
        self.pageControl.numberOfPages = images.count
        collectionView.reloadData()
    }
    
    @IBAction func pageControlValueChanged(_ sender: UIPageControl) {
        let page = sender.currentPage
        let offset = CGPoint(x: collectionView.frame.width * CGFloat(page), y: 0)
        collectionView.setContentOffset(offset, animated: true)
    }
    
    @IBAction func openArticleLink(_ sender: UIButton) {
        guard let url = viewModel.articleURL else { return }
        coordinatorDelegate?.didTapSafariLink(url: url)
    }
    
    @IBAction func openWikipediaLink(_ sender: UIButton) {
        guard let url = viewModel.wikipediaURL else { return }
        coordinatorDelegate?.didTapSafariLink(url: url)
    }
    
    @IBAction func openYouTubeFullScreen(_ sender: UIButton) {
        guard let videoId = viewModel.youtubeId else { return }
        coordinatorDelegate?.didTapYouTubeVideo(videoId: videoId)
    }
}

extension LaunchDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCell else {
            return UICollectionViewCell()
        }

        cell.configure(with: images[indexPath.item])
        return cell
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = page
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = page
    }
}
