//
//  DatabaseError.swift
//  DigitalWalletDemo
//
//  Created by Amr El Shazly on 12/08/2025.
//

import Foundation

enum DatabaseError: Error {
    case fileNotFound
    case decodingFailed
    var errorDescription: String? {
        switch self {
        case .fileNotFound:   return "expenses.json not found in the app bundle."
        case .decodingFailed: return "Failed to decode expenses.json."
        }
    }
}
