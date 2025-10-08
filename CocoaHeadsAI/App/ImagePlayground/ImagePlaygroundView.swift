//
//  ImagePlaygroundView.swift
//  CocoaHeadsAI
//
//  Created by Dimitri Brukakis on 05.10.25.
//

import SwiftUI
import ImagePlayground

struct ImagePlaygroundView: View {
    @State private var textInput: String = ""
    @State private var isThinking: Bool = false
    @State private var styles: [String] = []
    @State private var images: [CGImage] = []
    @State private var imagePrompt: String = ""
    
    @State private var isShowingError: Bool = false
    @State private var error: Error?
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    ForEach(styles, id: \.self) {
                        Text("\($0)")
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                
                VStack {
                    ForEach(images, id: \.self) { image in
                        Image(decorative: image, scale: 1.0)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300)
                    }
                }
            }
        }
        .alert("Error", isPresented: $isShowingError) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(error?.localizedDescription ?? "Some error")
        }
        .task(id: imagePrompt) {
            guard !imagePrompt.isEmpty else { return }
            do {
                let imageGenerator = try await ImageCreator()
                for try await generatedImage in imageGenerator.images(for: [.text(imagePrompt)], style: .animation, limit: 1) {
                    images.append(generatedImage.cgImage)
                }
            } catch {
                // Handle initialization errors from ImageCreator (e.g., .notSupported)
                print("Failed to initialize ImageCreator:", error)
                self.error = error
                isShowingError = true
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .safeAreaInset(edge: .bottom, content: {
            NiceTextInputField(textInput: $textInput, isThinking: $isThinking) {
                Task {
                    imagePrompt = textInput
                }
//                Task {
//                    isThinking = true
//                    addEmptyCard(placeholder: textInput)
//                    let answer = try await enviroment.ask(textInput)
//                    replaceLastCard(with: answer)
//                    isThinking = false
//                    textInput = ""
//                }
            }
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)

    }
}

#Preview {
    ImagePlaygroundView()
}
