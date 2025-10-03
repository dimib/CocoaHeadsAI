//
//  PlanForTheDay.swift
//  HamburgGuide
//
//  Created by Dimitri Brukakis on 28.09.25.
//

import Foundation
import FoundationModels

@Generable(description: "A plan for the day in Hamburg")
struct HamburgGuideDayPlan: Encodable, Hashable, Equatable {
    
    @Guide(description: "Title of the day")
    let title: String
    
    @Guide(description: "Date of the day")
    let date: String
    
    @Guide(description: "Activities")
    @Guide(.count(3))
    let activities: [HamburgGuideLocation]
    
    @Guide(description: "Journeys")
    @Guide(.count(3))
    let journeys: [TripPlannerJourney]
    
    static var schema: [String: Any?]? {
        do {
            let data = try JSONEncoder().encode(HamburgGuideDayPlan.generationSchema)
            let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any?]
            return dict
        } catch {
            return nil
        }
    }
}
