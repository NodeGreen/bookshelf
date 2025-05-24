//
//  CustomTextField.swift
//  BookShelf
//
//  Created by Endo on 24/05/25.
//

import SwiftUI

struct CustomTextField: View {
    let title: String
    let placeholder: String
    let text: Binding<String>
    let icon: String
    let keyboardType: UIKeyboardType
    
    init(title: String, placeholder: String, text: Binding<String>, icon: String, keyboardType: UIKeyboardType = .default) {
        self.title = title
        self.placeholder = placeholder
        self.text = text
        self.icon = icon
        self.keyboardType = keyboardType
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .foregroundColor(.blue)
                    .font(.subheadline)
                    .frame(width: 16)
                
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
            }
            
            TextField(placeholder, text: text)
                .textFieldStyle(.roundedBorder)
                .keyboardType(keyboardType)
        }
        .padding(.vertical, 4)
    }
}
