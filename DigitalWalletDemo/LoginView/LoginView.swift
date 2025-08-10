//
//  LoginView.swift
//  DigitalWalletDemo
//
//  Created by Amr El Shazly on 10/08/2025.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    
    var loginButton: some View {
        Button(action: {
            Task {
                try await viewModel.login()
            }
        }) {
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .black))
                    .frame(width: 300, height: 50)
                    .background(Color.greenBackground)
                    .cornerRadius(25)
            } else {
                Text("Log In")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.black)
                    .frame(width: 300, height: 50)
                    .background(Color.greenBackground)
                    .cornerRadius(25)
            }
        }
        .disabled(viewModel.username.isEmpty || viewModel.password.isEmpty || viewModel.isLoading)
        .opacity((viewModel.username.isEmpty || viewModel.password.isEmpty) ? 0.3 : 1)
        .padding(.horizontal, 24)
        .padding(.top, 70)
    }
    
    var forgetPasswordButton: some View {
        Button(action: {}) {
            Text("Forgot Password?")
                .font(.system(size: 14))
                .foregroundColor(.gray)
        }
        .padding(.top, 16)
    }
    
    var signUpButton: some View {
        Button(action: {}) {
            Text("Sign Up")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.black)
                .frame(width: 300, height: 50)
                .background(.lightGreen)
                .cornerRadius(25)
        }
        .padding(.horizontal, 24)
        .padding(.top, 20)
    }
    
    var fingerprintView: some View {
        HStack {
            Text("Use")
                .font(.system(size: 14))
                .foregroundColor(.black)
            
            Button(action: {}) {
                Text("Fingerprint")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.blue)
            }
            
            Text("To Access")
                .font(.system(size: 14))
                .foregroundColor(.black)
        }
        .padding(.top, 20)
    }
    
    var otherMethodsSignUp: some View {
        VStack(spacing: 16) {
            Text("or sign up with")
                .font(.system(size: 12))
                .foregroundColor(.gray)
            
            HStack(spacing: 20) {
                Button(action: {}) {
                    Image("Facebook")
                        .font(.system(size: 40))
                }
                
                Button(action: {}) {
                    Image("Google")
                        .font(.system(size: 40))
                }
            }
        }
        .padding(.top, 20)
    }
    
    var signUpView: some View {
        HStack {
            Text("Don't have an account?")
                .font(.system(size: 14))
                .foregroundColor(.gray)
            
            Button(action: {}) {
                Text("Sign Up")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.blue)
            }
        }
        .padding(.top, 20)
    }
    
    var body: some View {
        VStack {
            Text("Welcome")
                .font(.system(size: 32, weight: .semibold))
                .padding(40)
            
            ContainerView {
                VStack {
                    UserInfoView(
                        userName: $viewModel.username,
                        password: $viewModel.password,
                        isPasswordVisible: $viewModel.isPasswordVisible
                    )
                    
                    loginButton
                    forgetPasswordButton
                    signUpButton
                    fingerprintView
                    otherMethodsSignUp
                    signUpView
                }
            }
        }
        .background(Color.greenBackground)
        .alert("Invalid Credentials", isPresented: $viewModel.showError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(viewModel.errorMessage)
        }
        .fullScreenCover(isPresented: $viewModel.isAuthenticated) {
            HomeView()
        }
    }
}

#Preview {
    LoginView(viewModel: LoginViewModel())
}

struct UserInfoView: View {
    @Binding var userName: String
    @Binding var password: String
    @Binding var isPasswordVisible: Bool
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("Username Or Email")
                    .font(.system(size: 14, weight: .medium))
                TextField("username", text: $userName)
                    .font(.system(size: 16))
                    .padding()
                    .frame(width: 300)
                    .background(Color.lightGreen)
                    .cornerRadius(25)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }
            .padding()
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Password")
                    .font(.system(size: 14, weight: .medium))
                HStack {
                    if isPasswordVisible {
                        TextField("••••••••", text: $password)
                            .font(.system(size: 16))
                    } else {
                        SecureField("••••••••", text: $password)
                            .font(.system(size: 16))
                    }
                    
                    Button(action: {
                        isPasswordVisible.toggle()
                    }) {
                        Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                            .foregroundColor(.black)
                            .font(.system(size: 18))
                    }
                }
                .padding()
                .frame(width: 300)
                .background(Color.lightGreen)
                .cornerRadius(25)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            }
        }
    }
}
