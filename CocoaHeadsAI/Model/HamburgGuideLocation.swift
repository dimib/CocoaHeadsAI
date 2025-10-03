//
//  HamburgLocationGenerable.swift
//  HamburgGuide
//
//  Created by Dimitri Brukakis on 28.09.25.
//

import FoundationModels
@Generable(description: "HamburgGuideLocation")
struct HamburgGuideLocation: Codable, Hashable, Equatable {
    @Guide(description: "name")
    let name: String
    
    @Guide(description: "address")
    let address: String
    
    @Guide(description: "description")
    let description: String
    
    @Guide(description: "link")
    let link: String?
    
    @Guide(description: "type")
    let type: String
}
