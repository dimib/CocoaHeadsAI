//
//  SimpleStuff2.swift
//  CocoaHeadsAI
//
//  Created by Dimitri Brukakis on 04.10.25.
//

import Foundation
import FoundationModels
import Playgrounds

#Playground {
    let model = SystemLanguageModel()
    let languages = model.supportedLanguages.compactMap {
        if let code = $0.languageCode, let region = $0.region {
            return "\(code) \(region)"
        }
        return nil
    }
    let session = LanguageModelSession(model: model)
    let result = try await session.respond(to: "Wie geht es dir?")
}
