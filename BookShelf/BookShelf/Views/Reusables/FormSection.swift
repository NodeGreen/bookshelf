//
//  FormSection.swift
//  BookShelf
//
//  Created by Endo on 24/05/25.
//

import SwiftUI

struct FormSection: View {
    let content: () -> AnyView
    
    init<Content: View>(@ViewBuilder content: @escaping () -> Content) {
        self.content = { AnyView(content()) }
    }
    
    var body: some View {
        VStack(spacing: 16) {
            content()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 24)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(.systemGray5), lineWidth: 1)
        )
    }
}
