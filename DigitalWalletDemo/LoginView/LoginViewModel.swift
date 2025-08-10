//
//  LoginViewModel.swift
//  DigitalWalletDemo
//
//  Created by Amr El Shazly on 10/08/2025.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isPasswordVisible: Bool = false
    @Published var isLoading: Bool = false
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    @Published var isAuthenticated: Bool = false

    private var mockUser: User?
    
    init() {
        loadMockUser()
    }
    
    private func loadMockUser() {
        guard let url = Bundle.main.url(forResource: "MockUser", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            print("Failed to load MockUser.json")
            return
        }
        
        do {
            let mockData = try JSONDecoder().decode(User.self, from: data)
            self.mockUser = mockData
        } catch {
            print("Error decoding user: \(error)")
        }
    }

    func login() async throws {
        await MainActor.run {
            isLoading = true
            showError = false
            errorMessage = ""
        }
        
        try await Task.sleep(nanoseconds: 1_500_000_000)
        
        let result = authenticateUser()
        
        await MainActor.run {
            isLoading = false
            if result {
                isAuthenticated = true
                print("Login success for user: \(username)")
            } else {
                showError = true
                errorMessage = "Please enter correct user name or password"
                print("Login failed for user: \(username)")
            }
        }
    }
    
    private func authenticateUser() -> Bool {
        return mockUser?.username.lowercased() == username.lowercased() &&
        mockUser?.password == password

    }
}
