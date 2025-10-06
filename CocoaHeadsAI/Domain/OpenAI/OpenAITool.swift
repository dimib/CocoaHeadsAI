//
//  OpenAITool.swift
//  CocoaHeadsAI
//
//  Created by Dimitri Brukakis on 03.10.25.
//

import FoundationModels
import SwiftUI
import DBOpenAIClient


@Observable
final class OpenAITool: Tool {
    let name = "openAITool"
    let description = "Call OpenAI API."
    
    private let apikey = "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"
    private let baseURL = URL(string: "https://api.openai.com/v1")! // URL(string: "http://localhost:1234/v1")!
    let client: OpenAIClient

    init() {
        let client = OpenAIClient(baseUrl: baseURL, model: .gpt35turbo, apiKey: apikey)
        self.client = client
    }
    
    @Generable
    struct Arguments {
        @Guide(description: "Prompt")
        let prompt: String
    }

    @MainActor
    func call(arguments: Arguments) async throws -> String {
        debugPrint("Call OpenAI Tool: \(arguments.prompt)")
        let prompt = arguments.prompt
        
        let request = OpenAIChatRequest(model: .gpt4o,
                                        messages: [
                                            // OpenAIChatMessage(role: "user", content: "json"),
                                            OpenAIChatMessage(role: "user", content: prompt)
                                        ], response_format: OpenAIResponseFormat.text,
                                        max_tokens: 1000, temperature: 0.7)
        let response: OpenAIChatResponse = try await client.request(request: request, path: .completions)
    
        
        let result = response.choices.map({ $0.message.content }).joined(separator: "\n")
        debugPrint("Call OpenAI Tool: \(result)")
        return result
    }
}
