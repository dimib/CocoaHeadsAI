//
//  TripPlannerTool.swift
//  HamburgGuide
//
//  Created by Dimitri Brukakis on 26.09.25.
//

import FoundationModels
import SwiftUI
import TripPlanner

@Observable
final class TripPlannerTool: Tool {
    let name = "tripPlannerTool"
    let description = "Tool for public transportation trip planning."
    
    @Generable
    struct Arguments {
        @Guide(description: "start address")
        let start: String
        
        @Guide(description: "destination address")
        let destination: String
        
        @Guide(description: "Start or end of the trip")
        let date: String
    }
    
    @MainActor
    func call(arguments: Arguments) async throws -> TripPlannerJourney {
        let tripPlanner = TripPlanner()
        guard let startLocation = try await tripPlanner.findLocation(name: arguments.start).first,
              let destLocation = try await tripPlanner.findLocation(name: arguments.destination).first else {
            throw TripPlannerError.startOrDestinationNotFound("")
        }
     
        return TripPlannerJourney(start: startLocation.description, destination: destLocation.description)
    }
}

