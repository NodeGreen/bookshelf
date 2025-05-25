//
//  GenericPopup.swift
//  BookShelf
//
//  Created by Endo on 24/05/25.
//

import SwiftUI

struct PopupButton {
    let title: String
    let role: ButtonRole?
    let action: () -> Void
    
    init(title: String, role: ButtonRole? = nil, action: @escaping () -> Void = {}) {
        self.title = title
        self.role = role
        self.action = action
    }
}

struct GenericPopup: ViewModifier {
    let isPresented: Binding<Bool>
    let title: String
    let message: String
    let primaryButton: PopupButton
    let secondaryButton: PopupButton?
    
    init(
        isPresented: Binding<Bool>,
        title: String,
        message: String,
        primaryButton: PopupButton,
        secondaryButton: PopupButton? = nil
    ) {
        self.isPresented = isPresented
        self.title = title
        self.message = message
        self.primaryButton = primaryButton
        self.secondaryButton = secondaryButton
    }
    
    func body(content: Content) -> some View {
        content
            .alert(title, isPresented: isPresented) {
                if let secondary = secondaryButton {
                    Button(secondary.title, role: secondary.role) {
                        secondary.action()
                    }
                }
                
                Button(primaryButton.title, role: primaryButton.role) {
                    primaryButton.action()
                }
            } message: {
                Text(message)
            }
    }
}

extension View {
    func genericPopup(
        isPresented: Binding<Bool>,
        title: String,
        message: String,
        primaryButton: PopupButton,
        secondaryButton: PopupButton? = nil
    ) -> some View {
        modifier(GenericPopup(
            isPresented: isPresented,
            title: title,
            message: message,
            primaryButton: primaryButton,
            secondaryButton: secondaryButton
        ))
    }
}

#Preview("Popup generico con 2 bottoni") {
    Rectangle()
        .fill(Color.blue)
        .genericPopup(
            isPresented: .constant(true),
            title: "Permessi Camera",
            message: "Vuoi aprire le impostazioni per abilitare la fotocamera?",
            primaryButton: PopupButton(title: "Apri Impostazioni", role: .none) {
                print("Apri impostazioni")
            },
            secondaryButton: PopupButton(title: "Non ora", role: .cancel) {
                print("Annulla")
            }
        )
}

#Preview("Popup con 1 bottone") {
    Rectangle()
        .fill(Color.red)
        .genericPopup(
            isPresented: .constant(true),
            title: "Errore",
            message: "Si è verificato un errore durante l'operazione",
            primaryButton: PopupButton(title: "OK", role: .cancel)
        )
}
