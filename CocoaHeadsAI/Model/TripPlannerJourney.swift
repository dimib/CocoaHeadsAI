//
//  TripPlannerJourney.swift
//  HamburgGuide
//
//  Created by Dimitri Brukakis on 28.09.25.
//

import FoundationModels

enum TripPlannerError: Error {
    case startOrDestinationNotFound(String)
    case journeyNotFound
}

@Generable(description: "Journey")
struct TripPlannerJourney: Codable, Hashable, Equatable {
    @Guide(description: "Start of the journey")
    let start: String
    
    @Guide(description: "Destination of the journey")
    let destination: String
}
