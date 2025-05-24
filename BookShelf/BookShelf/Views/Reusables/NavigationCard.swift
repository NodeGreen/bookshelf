//
//  NavigationCard.swift
//  BookShelf
//
//  Created by Endo on 24/05/25.
//

import SwiftUI

struct NavigationCard: View {
    let title: String
    let icon: String
    let destination: AnyView
    
    var body: some View {
        NavigationLink(destination: destination) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .foregroundColor(.blue)
                    .font(.title2)
                    .frame(width: 24)
                
                Text(title)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
                    .font(.caption)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(Color(.systemGray6))
            .cornerRadius(12)
        }
        .buttonStyle(.plain)
    }
}
