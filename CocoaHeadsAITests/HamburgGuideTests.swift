//
//  HamburgGuideTests.swift
//  HamburgGuideTests
//
//  Created by Dimitri Brukakis on 26.09.25.
//

import Testing
import Foundation
import FoundationModels

final class HamburgGuideTests {
    
    @Test func example() async throws {
        let dayplan = HamburgGuideDayPlan(title: "This is your day",
                                          date: Date().formatted(),
                                          activities: [
                                            HamburgGuideLocation(name: "Alsterarkarden", address: "Irgendwo", description: "Kaufhaus", link: nil, type: "Adresse")],
                                          journeys: [.init(start: "Hier", destination: "Dort")])
        print(dayplan.title)
        
        //        let schema = HamburgGuideDayPlan.schema
        //        print(schema)
        
        let content = dayplan.generatedContent
        //        HamburgGuideDayPlan.generationSchema
        //        print(content)
        
        
        //        let bla = HamburgGuideDayPlan.self.generationSchema
    }
    
    @Generable
    struct HamburgGuideSummary {
        @Guide(description: "Funny title for your day")
        let title: String
        @Guide(description: "Suggested Location")
        @Guide(.count(3))
        let locations: [HamburgGuideLocation]
    }

    @Test func simpleStuff() async throws {
        let model = SystemLanguageModel(guardrails: .permissiveContentTransformations)
        
        let instructions = Instructions {
            "You are a friendly guy from Hamburg and can provide inside information."
            "For Restaurants use 'hamburgGuideTool' with type 'restaurants'"
            "For Hotel use 'hamburgGuideTool' with type 'hotels'"
            "Event use 'hamburgGuideTool' with type 'concerts'"
            "Shopping use 'hamburgGuideTool' with type 'shopping'"
            "Restaurants use 'hamburgGuideTool' with type 'restaurants'"
        }

        let hamburgGuide = HamburgGuideTool(Bundle(for: HamburgGuideTests.self))
        
        let session = LanguageModelSession(model: model,
                                           tools: [hamburgGuide],
                                           instructions: instructions)
        let prompt = Prompt {
            "I want to stay in Hamburg."
            "Find Restaurant and Event for Evening"
        }
        
        do {
            
            let result = try await session.respond(to: prompt, generating: HamburgGuideSummary.self)
            
            print("\(result.content)")
        } catch {
            print("\(error.localizedDescription)")
        }

    }
}
