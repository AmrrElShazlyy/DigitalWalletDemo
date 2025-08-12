//
//  HomeViewModel.swift
//  DigitalWalletDemo
//
//  Created by Amr El Shazly on 11/08/2025.
//

import Foundation
import Combine
import SwiftUI

final class HomeViewModel: ObservableObject {
    @Published var expensesData: ExpensesData?

    private var cancellables = Set<AnyCancellable>()
    private let databaseManager: DatabaseManager
    
    init(databaseManager: DatabaseManager = .shared) {
        self.databaseManager = databaseManager
    }
    
    func fetchData() async {
        await databaseManager.fetchExpensesData()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("Expenses Data Fetch completed successfully")
                case .failure(let error):
                    print("Expenses Data Fetch failed due to \(error)")
                }
            } receiveValue: { [weak self] expensesData in
                self?.expensesData = expensesData
            }
            .store(in: &cancellables)
    }
}
