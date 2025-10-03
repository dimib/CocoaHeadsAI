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
                    let answer = try await enviroment.ask(textInput)
                    answers.append(answer)
                    isThinking = false
                    textInput = ""
                }
            }
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
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
