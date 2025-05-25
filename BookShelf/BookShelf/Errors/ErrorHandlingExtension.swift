    //
//  TryButton.swift
//  BookShelf
//
//  Created by Endo on 25/05/25.
//


import SwiftUI

extension View {
    func handleError(_ error: Error, with errorHandler: ErrorHandler) {
        errorHandler.handle(error)
    }
    
    func handleAppError(_ appError: AppError, with errorHandler: ErrorHandler) {
        errorHandler.handle(appError)
    }
}

struct TryButton: View {
    let title: String
    let icon: String
    let colors: [Color]
    let action: () throws -> Void
    
    @EnvironmentObject private var errorHandler: ErrorHandler
    
    init(title: String, icon: String, colors: [Color] = [.blue, .blue.opacity(0.8)], action: @escaping () throws -> Void) {
        self.title = title
        self.icon = icon
        self.colors = colors
        self.action = action
    }
    
    var body: some View {
        GradientButton(title: title, icon: icon, colors: colors) {
            do {
                try action()
            } catch {
                errorHandler.handle(error)
            }
        }
    }
}
