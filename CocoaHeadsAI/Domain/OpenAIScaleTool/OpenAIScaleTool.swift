//
//  OpenAIScaleTool.swift
//  CocoaHeadsAI
//
//  Created by Dimitri Brukakis on 05.10.25.
//

import FoundationModels
import SwiftUI
import DBOpenAIClient


@Generable(description: "Scale definition")
struct Scale: Decodable {
    @Guide(description: "Name of the Scale")
    let name: String
    @Guide(description: "Name of the chords", .count(8))
    let chords: [Chord]
}

@Generable(description: "Chord definition")
struct Chord: Decodable {

    @Guide(description: "Name of the chord")
    let name: String

    @Guide(description: "Notes of the Chord")
    @Guide(.count(4))
    let notes: [String]
}


@Observable
final class OpenAIScaleTool: Tool {
    let name = "openAIScaleTool"
    let description = "Use OpenAI for requestion scale chords."

    let openAIKey: OpenAIKey = OpenAPIKeyReal()
    let client: OpenAIClient

    init() {
        let client = OpenAIClient(baseUrl: openAIKey.baseURL, model: .gpt35turbo, apiKey: openAIKey.apiKey)
        self.client = client
    }
    
    @Generable
    struct Arguments {
        @Guide(description: "Name of the scale")
        let scaleName: String
    }

    @MainActor
    func call(arguments: Arguments) async throws -> Scale {
        debugPrint("Call OpenAI Tool: \(arguments.scaleName)")
        let scaleName = arguments.scaleName
        
        let client = OpenAIClient(baseUrl: openAIKey.baseURL, model: .gpt4o, apiKey: openAIKey.apiKey)
        let request = OpenAIResponsesRequest(model: OpenAIDefines.Model.gpt4o.rawValue,
                                            input: [
                                                .init(role: "system", content: "You are an experienced music teacher and can help with music theory questions"),
                                                .init(role: "user", content: "I need the chords for an \(scaleName) scale")
                                            ],
                                            text: OpenAIText(format: OpenAIFormat(type: "json_schema",
                                                                                  name: "chord_scales",
                                                                                  schema: Scale.generationSchema,
                                                                                  strict: true)))
        do {
            let response: OpenAIResponsesResponse = try await client.request(request: request, path: .responses)
            let scales: [Scale]? = try response.decode(as: Scale.self)
            debugPrint("🎸🎸🎸")
            debugPrint(String(describing: scales))
            return scales!.first!
        } catch {
            debugPrint("Error: \(error.localizedDescription)")
            throw error
        }
    }
}
