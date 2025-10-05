//
//  SimpleStuff4.swift
//  CocoaHeadsAI
//
//  Created by Dimitri Brukakis on 04.10.25.
//

import Foundation
import FoundationModels
import Playgrounds

#Playground {
    let model = SystemLanguageModel(guardrails: .permissiveContentTransformations)
    let instructions = Instructions {
        "You are a friendly guy from Hamburg and can provide inside information about"
        "Restaurants"
        "Hotels"
        "Event"
        "Shopping"
    }
    
    let session = LanguageModelSession(model: model, instructions: instructions)
    let prompt = Prompt {
        "I want to stay in Hamburg."
        "Tell me a Restaurant and Event for the evening"
        "Tell me name and Adresses."
    }
    let result = try await session.respond(to: prompt)
}
