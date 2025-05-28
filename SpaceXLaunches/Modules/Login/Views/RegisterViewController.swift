//
//  RegisterViewController.swift
//  SpaceXLaunches
//
//  Created by Marco Alonso Rodriguez on 28/05/25.
//

import UIKit
import Combine

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    private var cancellables = Set<AnyCancellable>()
    private var loader: UIActivityIndicatorView!
    
    private let viewModel: RegisterViewModel
    
    init(viewModel: RegisterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Use init(viewModel:) instead")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLoader()
        setupBindings()
    }

    private func setupUI() {
        navigationItem.hidesBackButton = true
        signUpButton.layer.cornerRadius = 20
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textContentType = .password
    }

    private func setupLoader() {
        loader = UIActivityIndicatorView(style: .large)
        loader.center = view.center
        loader.hidesWhenStopped = true
        view.addSubview(loader)
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

    @IBAction func registerTapped(_ sender: UIButton) {
        viewModel.register(email: emailTextField.text ?? "", password: passwordTextField.text ?? "")
    }

    @IBAction func goBackLogin(_ sender: UIButton) {
        viewModel.onGoBackToLogin?()
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Info", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
