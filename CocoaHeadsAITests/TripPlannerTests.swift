//
//  TripPlannerTest.swift
//  HamburgGuideTests
//
//  Created by Dimitri Brukakis on 26.09.25.
//

import Testing

struct TripPlannerTests {

    @Test func testFindLocations() async throws {
        let tripPlanner = TripPlanner()
        let results = try await tripPlanner.findLocation(name: "Hamburg Hauptbahnhof")
        #expect(results.count > 1)
    }

}
