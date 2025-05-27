//
//  LaunchListViewController.swift
//  SpaceXLaunches
//
//  Created by Marco Alonso Rodriguez on 26/05/25.
//

import UIKit
import Combine

class LaunchListViewController: UIViewController {
    
    @IBOutlet weak var emptyStateLabel: UILabel!
    @IBOutlet weak var emptyStateImageView: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var launchesTableView: UITableView!
    
    private let viewModel: LaunchListViewModel
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: LaunchListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Use init(viewModel) to instantiate LaunchListViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        bindViewModel()
        viewModel.fetchLaunches()
        setupUI()
    }
    
    private func setupUI() {
        emptyStateImageView.isHidden = true
        emptyStateLabel.isHidden = true
        title = "Space X 🚀"
        view.backgroundColor = UIColor.systemGroupedBackground
        launchesTableView.backgroundColor = view.backgroundColor
        searchBar.delegate = self
        searchBar.placeholder = "Search by mission or site"
    }
    
    private func setupTableView() {
        launchesTableView.delegate = self
        launchesTableView.dataSource = self
        launchesTableView.register(UINib(nibName: "LaunchTableViewCell", bundle: nil), forCellReuseIdentifier: "LaunchCell")
        launchesTableView.rowHeight = 130
        launchesTableView.separatorStyle = .none
    }
    
    private func bindViewModel() {
        viewModel.$launches
            .receive(on: RunLoop.main)
            .sink { [weak self] launches in
                guard let self = self else { return }
                
                let showEmptyImage = launches.isEmpty
                UIView.transition(with: self.emptyStateImageView,
                                  duration: 0.3,
                                  options: .transitionCrossDissolve,
                                  animations: {
                    self.emptyStateImageView.isHidden = !showEmptyImage
                    self.emptyStateLabel.isHidden = !showEmptyImage
                })
                
                UIView.transition(with: self.launchesTableView,
                                  duration: 0.25,
                                  options: .transitionCrossDissolve,
                                  animations: {
                    self.launchesTableView.reloadData()
                })
            }
            .store(in: &cancellables)
        
        viewModel.$errorMessage
            .compactMap { $0 }
            .sink { [weak self] error in
                self?.showError(error)
            }
            .store(in: &cancellables)
    }
    
    private func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension LaunchListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.launches.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard viewModel.launches.indices.contains(indexPath.row),
              let cell = tableView.dequeueReusableCell(withIdentifier: "LaunchCell", for: indexPath) as? LaunchTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: viewModel.launches[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let launch = viewModel.launches[indexPath.row]
        viewModel.selectLaunch(launch)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.layer.masksToBounds = true
        cell.contentView.layer.cornerRadius = 12
        cell.contentView.layer.borderWidth = 0
        cell.backgroundColor = .clear
    }
}

extension LaunchListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterLaunches(query: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
