//
//  SimpleStuff.swift
//  CocoaHeadsAI
//
//  Created by Dimitri Brukakis on 04.10.25.
//

import Foundation
import FoundationModels
import Playgrounds

#Playground {
    let model = SystemLanguageModel()
    let session = LanguageModelSession(model: model)
    let result = try await session.respond(to: "How are you?")
}
