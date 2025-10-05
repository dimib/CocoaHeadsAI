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
final class AskMeAnythingEnvironment {
    
    private let instructions = Instructions {
        "Answer as a friendly guide from Hamburg!"
        "Give tips about special hotels, restaurants, museums, concerts."
        "Never think about locations or activities for yourself! Always use a tool."
        "For 'day activity' use the 'hamburgGuideTool' with the location type 'locations' or 'shopping'"
        "For 'Restaurant use the 'hamburgGuideTool' with location type 'restaurants'"
        "For 'Hotel' use the 'hamburgGuideTool' with location type 'hotels'"
        "For 'evening activity' use the 'hamburgGuideTool' with location type 'concerts'"
        "For 'journey' use the 'tripPlannerTool', always use the location parameter 'address'"
        
    }
    
    private let hamburgGuideTool = HamburgGuideTool()
    private let tripPlannerTool = TripPlannerTool()
    
    private var session: LanguageModelSession

    init() {
        let session = LanguageModelSession(tools: [hamburgGuideTool], instructions: instructions)
        session.prewarm()
        self.session = session
    }
    
    func ask(_ input: String) async throws -> String {
        let today = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .none)
        let prompt = Prompt {
            "Date: \(today)"
            input
        }
        let response = try await session.respond(to: prompt)
        debugPrint(response.content)
        return response.content
    }
    
    func generateActivityPlan() async throws -> HamburgGuideDayPlan {
        let session = LanguageModelSession(tools: [hamburgGuideTool], instructions: instructions)
        session.prewarm()

        let today = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .none)
        let prompt = Prompt {
            "Generate a day plan for activty in Hamburg on \(today)"
            "1. Find 'day activity', use 'hamburgGuideTool' with type 'location' or 'shopping'"
            "2. Find 'Restaurant' for dinner, use 'hamburgGuideTool' with type 'restaurants'"
            "3. Find 'evening activity', use 'hamburgGuideTool' with type 'concerts'"
            
            "Find a 'journey' between the 'day activity' and 'Restaurant'"
            "Find a journey between 'Resturant' and 'evening activity'"
        }
        let response = try await session.respond(to: prompt, generating: HamburgGuideDayPlan.self)
        debugPrint(response.content)
        return response.content
        
    }
}
