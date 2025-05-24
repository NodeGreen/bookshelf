//
//  ConfirmationPopup.swift
//  BookShelf
//
//  Created by Endo on 24/05/25.
//


import SwiftUI

struct ConfirmationPopup: ViewModifier {
    let isPresented: Binding<Bool>
    let title: String
    let message: String
    let confirmTitle: String
    let cancelTitle: String
    let confirmAction: () -> Void
    
    init(
        isPresented: Binding<Bool>,
        title: String,
        message: String,
        confirmTitle: String = "Conferma",
        cancelTitle: String = "Annulla",
        confirmAction: @escaping () -> Void
    ) {
        self.isPresented = isPresented
        self.title = title
        self.message = message
        self.confirmTitle = confirmTitle
        self.cancelTitle = cancelTitle
        self.confirmAction = confirmAction
    }
    
    func body(content: Content) -> some View {
        content
            .alert(title, isPresented: isPresented) {
                Button(cancelTitle, role: .cancel) { }
                Button(confirmTitle, role: .destructive) {
                    confirmAction()
                }
            } message: {
                Text(message)
            }
    }
}

extension View {
    func confirmationPopup(
        isPresented: Binding<Bool>,
        title: String,
        message: String,
        confirmTitle: String = "Conferma",
        cancelTitle: String = "Annulla",
        confirmAction: @escaping () -> Void
    ) -> some View {
        modifier(ConfirmationPopup(
            isPresented: isPresented,
            title: title,
            message: message,
            confirmTitle: confirmTitle,
            cancelTitle: cancelTitle,
            confirmAction: confirmAction
        ))
    }
}

#Preview {
    Rectangle()
        .fill(Color.red)
        .confirmationPopup(isPresented: .constant(true), title: "test", message: "test", confirmAction: {})
}
