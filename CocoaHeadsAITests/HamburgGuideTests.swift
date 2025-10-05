//
//  HamburgGuideTests.swift
//  HamburgGuideTests
//
//  Created by Dimitri Brukakis on 26.09.25.
//

import Testing
import Foundation
import FoundationModels

struct HamburgGuideTests {

    @Test func example() async throws {
        let dayplan = HamburgGuideDayPlan(title: "This is your day",
                                          date: Date().formatted(),
                                          activities: [
                                            HamburgGuideLocation(name: "Alsterarkarden", address: "Irgendwo", description: "Kaufhaus", link: nil, type: "Adresse")],
                                          journeys: [.init(start: "Hier", destination: "Dort")])
        print(dayplan.title)
        
        let schema = HamburgGuideDayPlan.schema
        print(schema)
        
        let content = dayplan.generatedContent
        HamburgGuideDayPlan.generationSchema
        print(content)
        
        
        let bla = HamburgGuideDayPlan.self.generationSchema
    }

    @Test func simpleStuff() async throws {
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
            print("\(result)")
        } catch {
            print("\(error.localizedDescription)")
        }

    }
}
