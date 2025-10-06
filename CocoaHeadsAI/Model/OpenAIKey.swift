//
//  OpenAIKey.swift
//  CocoaHeadsAI
//
//  Created by Dimitri Brukakis on 06.10.25.
//

import Foundation

protocol OpenAIKey: Sendable {
    var apiKey: String { get }
    var baseURL: URL { get }
}
