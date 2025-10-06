//
//  OpenAITests.swift
//  CocoaHeadsAITests
//
//  Created by Dimitri Brukakis on 05.10.25.
//

import Foundation
import FoundationModels
import Testing
import DBOpenAIClient

// https://platform.openai.com/docs/guides/structured-outputs

struct OpenAITests {

    let openAIKey: OpenAIKey = OpenAPIKeyReal()
    
    @Generable(description: "Scale definition")
    struct Scale: Decodable {
        @Guide(description: "Name of the Scale")
        let name: String
        @Guide(description: "Name of the chords", .count(8))
        let chords: [String]
    }

    @Generable(description: "Chord definition")
    struct Chord: Decodable {

        @Guide(description: "Name of the chord")
        let name: String
    
        @Guide(description: "Notes of the Chord")
        @Guide(.count(4))
        let notes: [String]
    }

    @Test func testOpenAI() async throws {
        
        let schema = try String(data: JSONEncoder().encode(Chord.generationSchema), encoding: .utf8)
        
        
        assert(schema != nil)
        
        let client = OpenAIClient(baseUrl: openAIKey.baseURL, model: .gpt4o, apiKey: openAIKey.apiKey)
        let request = OpenAIResponsesRequest(model: OpenAIDefines.Model.gpt4o.rawValue,
                                            input: [
                                                .init(role: "system", content: "You are an experienced music teacher and can help with music theory questions"),
                                                .init(role: "user", content: "I need the chords for an C major scale")
                                            ],
                                            text: OpenAIText(format: OpenAIFormat(type: "json_schema",
                                                                                  name: "chord_scales",
                                                                                  schema: Scale.generationSchema,
                                                                                  strict: true)))
        
        let response: OpenAIResponsesResponse = try await client.request(request: request, path: .responses)
        
        let generatedContent = try GeneratedContent(json: response.output.first!.content.first!.text)
        let scale = try Scale(generatedContent)

        let scales: [Scale]? = try response.decode(as: Scale.self)

        print("💁 \(String(describing: scales))")
    }

}
