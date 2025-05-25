//
//  AppError.swift
//  BookShelf
//
//  Created by Endo on 25/05/25.
//


import Foundation

enum AppError: LocalizedError, Identifiable {
    case coreDataSaveFailed(Error)
    case coreDataFetchFailed(Error)
    case coreDataDeleteFailed(Error)
    case invalidISBN(String)
    case cameraPermissionDenied
    case scanningFailed(Error)
    case bookValidationFailed(String)
    case networkError(Error)
    case unknown(Error)
    
    var id: String {
        errorDescription ?? "unknown_error"
    }
    
    var errorDescription: String? {
        switch self {
        case .coreDataSaveFailed:
            return "Errore durante il salvataggio"
        case .coreDataFetchFailed:
            return "Errore durante il caricamento dei dati"
        case .coreDataDeleteFailed:
            return "Errore durante l'eliminazione"
        case .invalidISBN(let isbn):
            return "ISBN non valido: \(isbn)"
        case .cameraPermissionDenied:
            return "Permessi fotocamera negati"
        case .scanningFailed:
            return "Errore durante la scansione"
        case .bookValidationFailed(let field):
            return "Campo obbligatorio: \(field)"
        case .networkError:
            return "Errore di connessione"
        case .unknown:
            return "Si è verificato un errore"
        }
    }
    
    var recoverySuggestion: String? {
        switch self {
        case .coreDataSaveFailed, .coreDataFetchFailed, .coreDataDeleteFailed:
            return "Riprova più tardi. Se il problema persiste, riavvia l'app."
        case .invalidISBN:
            return "Controlla che l'ISBN sia nel formato corretto (10 o 13 cifre)."
        case .cameraPermissionDenied:
            return "Vai nelle Impostazioni per abilitare l'accesso alla fotocamera."
        case .scanningFailed:
            return "Assicurati che il codice sia ben visibile e riprova."
        case .bookValidationFailed:
            return "Compila tutti i campi obbligatori prima di salvare."
        case .networkError:
            return "Controlla la connessione internet e riprova."
        case .unknown:
            return "Riprova più tardi."
        }
    }
    
    var shouldShowSettings: Bool {
        switch self {
        case .cameraPermissionDenied:
            return true
        default:
            return false
        }
    }
}