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

}
