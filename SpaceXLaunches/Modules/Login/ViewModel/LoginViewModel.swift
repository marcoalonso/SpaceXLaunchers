//
//  LoginViewModel.swift
//  SpaceXLaunches
//
//  Created by Marco Alonso Rodriguez on 28/05/25.
//

import Foundation
import FirebaseAuth
import Combine

final class LoginViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var errorMessage: String?
    var onLoginSuccess: (() -> Void)?
    var onRegisterTap: (() -> Void)?
    
    func login(email: String, password: String) {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please enter email and password."
            return
        }
        
        isLoading = true
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                if let error = error {
                    self?.errorMessage = "Login failed: \(error.localizedDescription)"
                    return
                }
                self?.onLoginSuccess?()
            }
        }
    }
}
