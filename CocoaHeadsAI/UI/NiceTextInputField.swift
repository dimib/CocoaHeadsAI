//
//  NiceTextInputField.swift
//  CocoaHeadsAI
//
//  Created by Dimitri Brukakis on 03.10.25.
//

import SwiftUI

struct NiceTextInputField: View {
    
    @Binding var textInput: String
    @Binding var isThinking: Bool
    let onSubmit: () -> Void
    
    @State var angle = Angle(degrees: 0)
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "apple.intelligence")
                .foregroundStyle(.secondary)
                .rotationEffect(angle)
            
            TextField("Ask me…", text: $textInput, axis: .vertical)
                .textFieldStyle(.plain)
                .lineLimit(1...4)
                .textInputAutocapitalization(.sentences)
                .autocorrectionDisabled(false)
                .submitLabel(.send)
                .onSubmit(onSubmit)
                .disabled(isThinking)
            
            Button(action: onSubmit) {
                Image(systemName: "paperplane.fill")
                    .font(.system(size: 16, weight: .semibold))
                    .symbolRenderingMode(.hierarchical)
                    .padding(8)
                    .foregroundStyle(.white)
                    .background(
                        Capsule().fill(Color.accentColor.opacity(textInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? 0.3 : 1))
                    )
            }
            .disabled(textInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            .accessibilityLabel("Send")
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .strokeBorder(Color.secondary.opacity(0.15), lineWidth: 1)
        )
        .padding(.horizontal, 12)
        .padding(.top, 8)
        .padding(.bottom, 8)
        .onChange(of: isThinking) { oldValue, newValue in
            if newValue {
                withAnimation(.linear(duration: 5.0).repeatForever(autoreverses: false)) {
                    angle = .degrees(360)
                }
            } else {
                withAnimation(.easeOut(duration: 0.5)) {
                    angle = .degrees(0)
                }
            }
        }
    }
}
