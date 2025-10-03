//
//  AskMeAnythingEnvironment.swift
//  CocoaHeadsAI
//
//  Created by Dimitri Brukakis on 03.10.25.
//

import Foundation
import SwiftUI
import FoundationModels

@Observable
final class AskChatGPTEnvironment {
    
    private let instructions = Instructions {
        "Answer as a friendly guy from Hamburg!"
        "Give tips about special hotels, restaurants, museums, concerts."
        "Never think about locations or activities for yourself! Always use the 'openAITool'."
        "Just take the answer of the 'openAITool' and use it as a guide!"
    }
    private let openAITool = OpenAITool()
    
    private var session: LanguageModelSession

    init() {
        let session = LanguageModelSession(tools: [openAITool], instructions: instructions)
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
