//
//  DatabaseManager.swift
//  DigitalWalletDemo
//
//  Created by Amr El Shazly on 11/08/2025.
//

import Foundation
import Combine

/// DatabaseManager is implemented as an `actor` to model a production-ready, thread-safe data layer. For this demo it isn’t strictly necessary because we read a bundled JSON exactly once and there are no concurrent calls from multiple layers.
actor DatabaseManager {
    static let shared = DatabaseManager()
    
    private nonisolated func fetchMoneyData() throws -> ExpensesData {
        guard let url = Bundle.main.url(forResource: "expenses", withExtension: "json") else {
            throw DatabaseError.fileNotFound
        }
        let data = try Data(contentsOf: url)
        do {
            return try JSONDecoder().decode(ExpensesData.self, from: data)
        } catch {
            throw DatabaseError.decodingFailed
        }
    }
    
    func fetchExpensesData() -> AnyPublisher<ExpensesData, DatabaseError> {
        Result {
            try fetchMoneyData()
        }
        .mapError { ($0 as? DatabaseError) ?? .decodingFailed }
        .publisher
        .eraseToAnyPublisher()
    }
}
