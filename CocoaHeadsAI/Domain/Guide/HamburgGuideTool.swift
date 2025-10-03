//
//  HamburgGuideTool.swift
//  HamburgGuide
//
//  Created by Dimitri Brukakis on 28.09.25.
//

import FoundationModels
import SwiftUI

@Observable
final class HamburgGuideTool: Tool {
    let name = "hamburgGuideTool"
    let description = "Search locations in Hamburg"
    
    @Generable
    struct Arguments {
        let type: String
        let name: String
    }

    @MainActor
    func call(arguments: Arguments) async throws -> HamburgGuideLocation {
        guard let type = HamburgLocationType(rawValue: arguments.type),
              let locations = HamburgGuide().loadItems(type: type) else {
            throw HamburgLocationsLoadingError.fileNotFound
        }
        
        let randomIndex = Int.random(in: 0..<locations.count)
        let location = locations[randomIndex]
        return HamburgGuideLocation(
            name: location.name,
            address: location.address,
            description: location.description, link: location.link?.absoluteString,
            type: type.rawValue)
    }
}
