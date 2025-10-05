//
//  SimpleStuff5.swift
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
        "For Restaurants use 'hamburgGuideTool' with type 'restaurant'"
        "For Hotel use 'hamburgGuideTool' with type 'hotel'"
        "Event use 'hamburgGuideTool' with type 'concerts'"
        "Shopping use 'hamburgGuideTool' with type 'shopping'"
    }
    
    let hamburgGuide = HamburgGuideTool()
    
    let session = LanguageModelSession(model: model,
                                       tools: [hamburgGuide],
                                       instructions: instructions)
    let prompt = Prompt {
        "I want to stay in Hamburg."
        "Tell me a Restaurant and Event for the evening"
        "Tell me name and Adresses."
    }
    do {
        let result = try await session.respond(to: prompt)
    } catch {
        print("\(error.localizedDescription)")
    }
}
