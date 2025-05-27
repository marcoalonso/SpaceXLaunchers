//
//  LaunchListViewController.swift
//  SpaceXLaunches
//
//  Created by Marco Alonso Rodriguez on 26/05/25.
//

import UIKit
import Combine

class LaunchListViewController: UIViewController {
    
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
    }
    
    private func setupUI() {
        titleLabel.textColor = .primary
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
            .sink { [weak self] _ in
                self?.launchesTableView.reloadData()
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LaunchCell", for: indexPath) as? LaunchTableViewCell else {
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
