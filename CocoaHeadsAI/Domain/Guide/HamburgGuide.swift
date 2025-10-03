//
//  HamburgGuide.swift
//  HamburgGuide
//
//  Created by Dimitri Brukakis on 28.09.25.
//

import Foundation

final class HamburgGuide {

    /// Load all items for the specified `HamburgLocationType`
    /// - parameter type: Item type to load (restaurant, concert, ...)
    /// - returns all items of this type or `nil`, if there is data for this type
    func loadItems(type: HamburgLocationType) -> [HamburgLocationItem]? {
        let items = loadItems(name: type.rawValue)
        return items.isEmpty ? nil : items
    }
    
    /// Loads and decodes the full `Locations` object from concerts.json in the specified bundle.
    /// - Parameter bundle: The bundle to search (defaults to `.main`).
    /// - Throws: `ConcertsLoadingError` if the file can't be found or decoding fails.
    /// - Returns: A decoded `Concerts` value.
    @discardableResult
    private func load(from bundle: Bundle = .main, name: String) throws -> HamburgLocations {
        guard let url = bundle.url(forResource: name, withExtension: "json") else {
            throw HamburgLocationsLoadingError.fileNotFound
        }
        let data = try Data(contentsOf: url)
        do {
            return try JSONDecoder().decode(HamburgLocations.self, from: data)
        } catch {
            throw HamburgLocationsLoadingError.decodingFailed(error)
        }
    }

    /// Convenience to directly get the array of venues.
    private func loadItems(from bundle: Bundle = .main, name: String) -> [HamburgLocationItem] {
        do {
            return try load(from: bundle, name: name).items
        } catch {
            return []
        }
    }
}
