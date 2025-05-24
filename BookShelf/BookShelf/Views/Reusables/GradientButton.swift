//
//  ScanButton.swift
//  BookShelf
//
//  Created by Endo on 24/05/25.
//

import SwiftUI

struct GradientButton: View {
    let title: String
    let icon: String
    let colors: [Color]
    let action: () -> Void
    
    init(title: String, icon: String, colors: [Color] = [.blue, .blue.opacity(0.8)], action: @escaping () -> Void) {
        self.title = title
        self.icon = icon
        self.colors = colors
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .imageScale(.large)
                Text(title)
                    .fontWeight(.medium)
            }
            .foregroundColor(.white)
            .padding(.vertical, 16)
            .padding(.horizontal, 24)
            .background(
                LinearGradient(
                    colors: colors,
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .cornerRadius(12)
            .shadow(color: colors.first?.opacity(0.3) ?? .clear, radius: 8, x: 0, y: 4)
        }
        .buttonStyle(.plain)
    }
}
