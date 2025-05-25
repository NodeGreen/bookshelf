//
//  ErrorHandler.swift
//  BookShelf
//
//  Created by Endo on 25/05/25.
//


import Foundation
import UIKit

final class ErrorHandler: ObservableObject {
    @Published var currentError: AppError?
    
    private let permissionsManager: PermissionsManager
    
    init(permissionsManager: PermissionsManager = PermissionsManager()) {
        self.permissionsManager = permissionsManager
    }
    
    func handle(_ error: Error) {
        let appError = mapToAppError(error)
        DispatchQueue.main.async {
            self.currentError = appError
        }
    }
    
    func handle(_ appError: AppError) {
        DispatchQueue.main.async {
            self.currentError = appError
        }
    }
    
    func clearError() {
        currentError = nil
    }
    
    func handleErrorAction() {
        guard let error = currentError else { return }
        
        if error.shouldShowSettings {
            permissionsManager.openAppSettings()
        }
        
        clearError()
    }
    
    var hasError: Bool {
        currentError != nil
    }
    
    var errorTitle: String {
        currentError?.errorDescription ?? "Errore"
    }
    
    var errorMessage: String {
        currentError?.recoverySuggestion ?? "Si è verificato un errore"
    }
    
    var primaryButtonTitle: String {
        currentError?.shouldShowSettings == true ? "Apri Impostazioni" : "OK"
    }
    
    var shouldShowSecondaryButton: Bool {
        currentError?.shouldShowSettings == true
    }
    
    private func mapToAppError(_ error: Error) -> AppError {
        if let appError = error as? AppError {
            return appError
        }
        
        let errorDescription = error.localizedDescription.lowercased()
        
        if errorDescription.contains("core data") || errorDescription.contains("persistent") {
            return .coreDataSaveFailed(error)
        }
        
        if errorDescription.contains("network") || errorDescription.contains("connection") {
            return .networkError(error)
        }
        
        return .unknown(error)
    }
}
