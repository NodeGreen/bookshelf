//
//  ErrorHandlingModifier.swift
//  BookShelf
//
//  Created by Endo on 25/05/25.
//


import SwiftUI

struct ErrorHandlingModifier: ViewModifier {
    @ObservedObject var errorHandler: ErrorHandler
    
    func body(content: Content) -> some View {
        content
            .genericPopup(
                isPresented: .constant(errorHandler.hasError),
                title: errorHandler.errorTitle,
                message: errorHandler.errorMessage,
                primaryButton: PopupButton(
                    title: errorHandler.primaryButtonTitle,
                    role: errorHandler.currentError?.shouldShowSettings == true ? .none : .cancel
                ) {
                    errorHandler.handleErrorAction()
                },
                secondaryButton: errorHandler.shouldShowSecondaryButton ?
                    PopupButton(title: "Annulla", role: .cancel) {
                        errorHandler.clearError()
                    } : nil
            )
    }
}

extension View {
    func withErrorHandling(errorHandler: ErrorHandler) -> some View {
        modifier(ErrorHandlingModifier(errorHandler: errorHandler))
    }
}
