//
//  HamburgLocationGenerable.swift
//  HamburgGuide
//
//  Created by Dimitri Brukakis on 28.09.25.
//

import FoundationModels

@Generable(description: "HamburgGuideLocation")
struct HamburgGuideLocation: Codable, Hashable, Equatable {
    @Guide(description: "The locations name")
    let name: String
    
    @Guide(description: "Locations address")
    let address: String
    
    @Guide(description: "Short description about the location")
    let description: String
    
    @Guide(description: "Link for more information")
    let link: String?
    
    @Guide(description: "The location type")
    let type: String
}
