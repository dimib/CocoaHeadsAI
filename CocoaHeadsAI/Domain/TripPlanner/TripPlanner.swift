//
//  TripPlanner.swift
//  HamburgGuide
//
//  Created by Dimitri Brukakis on 26.09.25.
//

import Foundation
import TripPlanner

struct TripPlanner {
    
    let theTripPlanner = TripPlannerGeofox()
    
    func findLocation(name: String, city: String? = nil) async throws -> [InfoService.Location] {
        do {
            return try await theTripPlanner.findLocation(name: name, city: city)
        } catch {
            debugPrint("💀 trip planner returned: \(error.localizedDescription)")
            return []
        }
    }
}
