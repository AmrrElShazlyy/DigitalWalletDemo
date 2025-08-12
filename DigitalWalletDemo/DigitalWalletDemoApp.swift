//
//  DigitalWalletDemoApp.swift
//  DigitalWalletDemo
//
//  Created by Amr El Shazly on 10/08/2025.
//

import SwiftUI

@main
struct DigitalWalletDemoApp: App {
    @StateObject private var loginViewModel = LoginViewModel()

    var body: some Scene {
        WindowGroup {
            LoginView(viewModel: loginViewModel)
        }
    }
}
