//
//  RegisterViewModel.swift
//  SpaceXLaunches
//
//  Created by Marco Alonso Rodriguez on 28/05/25.
//

import Foundation
import FirebaseAuth
import Combine

final class RegisterViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    var onRegisterSuccess: (() -> Void)?
    var onGoBackToLogin: (() -> Void)?
    
    func register(email: String, password: String) {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please enter both email and password."
            return
        }
        
        guard isValidEmail(email) else {
            errorMessage = "Please enter a valid email address."
            return
        }
        
        guard password.count >= 6 else {
            errorMessage = "Password must be at least 6 characters."
            return
        }
        
        isLoading = true
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                if let error = error {
                    self?.errorMessage = "Registration failed: \(error.localizedDescription)"
                    return
                }
                self?.onRegisterSuccess?()
            }
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format:"SELF MATCHES %@", emailRegEx).evaluate(with: email)
    }
}
