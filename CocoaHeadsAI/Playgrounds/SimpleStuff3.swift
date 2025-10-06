//
//  SimpleStuff3.swift
//  CocoaHeadsAI
//
//  Created by Dimitri Brukakis on 04.10.25.
//

import Foundation
import FoundationModels
import Playgrounds

// https://developer.apple.com/documentation/foundationmodels/improving-safety-from-generative-model-output
#Playground {
    let model = SystemLanguageModel(guardrails: .default)
    let instructions = Instructions {
        "You are a commedian and best know to tell jokes."
    }
    let session = LanguageModelSession(model: model, instructions: instructions)
    let result = try await session.respond(to: "Tell a random joke about Donald Trump.")
}

#Playground {
    let model = SystemLanguageModel(guardrails: .permissiveContentTransformations)
    let instructions = Instructions {
        "You are a politician"
        "Answer with long and unclear sentences"
        "Say a lot without saying anything clear."
    }
    let session = LanguageModelSession(model: model, instructions: instructions)
    let result = try await session.respond(to: "Write a talk: Why are E-Cards not the future. Answer in German.")
}
