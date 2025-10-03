// Concerts.swift
// Models for decoding Resources/concerts.json

import Foundation
import FoundationModels

/// We have different types of locations to distinguish
enum HamburgLocationType: String, Codable {
    case hotels
    case locations
    case concerts
    case shopping
    case restaurants
}

/// Top-level container that mirrors the JSON structure: { "items": [ ... ] }
public struct HamburgLocations: Codable {
    public let items: [HamburgLocationItem]
}

/// A single concert venue/location entry.
/// Maps German JSON keys to idiomatic Swift property names.
public struct HamburgLocationItem: Codable, Hashable {
    public let name: String
    public let address: String        // JSON: "adresse"
    public let description: String    // JSON: "beschreibung"
    public let link: URL?

    enum CodingKeys: String, CodingKey {
        case name
        case address = "adresse"
        case description = "beschreibung"
        case link
    }
}
/// Errors that can occur when loading/decoding concerts.json
public enum HamburgLocationsLoadingError: Error {
    case fileNotFound
    case decodingFailed(Error)
}
