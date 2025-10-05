//
//  AskMeAnythingView.swift
//  CocoaHeadsAI
//
//  Created by Dimitri Brukakis on 03.10.25.
//

import SwiftUI

struct AskMeAnythingView: View {
    @Environment(AskMeAnythingEnvironment.self) var enviroment

    @State private var textInput: String = ""
    @State private var answers: [String] = []
    @State private var isThinking: Bool = false
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    ForEach(answers, id: \.self) {
                        TextContentCardView(title: "Answer",
                                            text: $0, icon: "sparkles",
                                            footnote: "Answerd with ❤️")
                    }
                }
                .padding(.horizontal, 16)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .safeAreaInset(edge: .bottom, content: {
            NiceTextInputField(textInput: $textInput, isThinking: $isThinking) {
                Task {
                    isThinking = true
                    addEmptyCard(placeholder: textInput)
                    let answer = try await enviroment.ask(textInput)
                    replaceLastCard(with: answer)
                    isThinking = false
                    textInput = ""
                }
            }
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    func addEmptyCard(placeholder: String) {
        withAnimation {
            answers.append(placeholder)
        }
    }
    
    func replaceLastCard(with string: String) {
        withAnimation {
            answers.removeLast()
            answers.append(string)
        }
    }
    
    private func send() {
        let trimmed = textInput.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        // TODO: Hook into your chat logic here
        print("User prompt:", trimmed)
        textInput = ""
    }
}



#Preview {
    AskMeAnythingView()
}
