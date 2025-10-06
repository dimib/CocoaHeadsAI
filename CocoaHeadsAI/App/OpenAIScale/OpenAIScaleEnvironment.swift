//
//  OpenAIScaleEnvironment.swift
//  CocoaHeadsAI
//
//  Created by Dimitri Brukakis on 05.10.25.
//

import Foundation
import SwiftUI
import FoundationModels

@Observable
final class OpenAIScaleEnvironment {
    
    private let instructions = Instructions {
        "You are a music teacher"
        "Answer all questions about scales using 'openAIScaleTool' with the scale name"
    }
    private let scaleTool = OpenAIScaleTool()
    
    private var session: LanguageModelSession

    init() {
        let session = LanguageModelSession(tools: [scaleTool], instructions: instructions)
        session.prewarm()
        self.session = session
    }
    
    func ask(_ input: String) async throws -> String {
        let prompt = Prompt {
            input
        }
        let response = try await session.respond(to: prompt)
        debugPrint(response.content)
        return response.content
    }
}
