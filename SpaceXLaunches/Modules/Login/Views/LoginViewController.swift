//
//  LoginViewController.swift
//  SpaceXLaunches
//
//  Created by Marco Alonso Rodriguez on 28/05/25.
//

import UIKit
import Combine

class LoginViewController: UIViewController {
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    private var cancellables = Set<AnyCancellable>()
    private var loader: UIActivityIndicatorView!
    
    private let viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Use init(viewModel:) instead")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        setupLoader()
    }

    private func setupBindings() {
        viewModel.$isLoading
            .receive(on: RunLoop.main)
            .sink { [weak self] isLoading in
                isLoading ? self?.loader.startAnimating() : self?.loader.stopAnimating()
            }
            .store(in: &cancellables)
        
        viewModel.$errorMessage
            .compactMap { $0 }
            .sink { [weak self] message in
                self?.showAlert(message: message)
            }
            .store(in: &cancellables)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Info", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    private func setupLoader() {
        loader = UIActivityIndicatorView(style: .large)
        loader.center = view.center
        loader.hidesWhenStopped = true
        view.addSubview(loader)
    }

    @IBAction func loginTapped(_ sender: UIButton) {
        viewModel.login(email: emailTextField.text ?? "", password: passwordTextField.text ?? "")
    }

    @IBAction func goToRegister(_ sender: UIButton) {
        viewModel.onRegisterTap?()
    }
}
