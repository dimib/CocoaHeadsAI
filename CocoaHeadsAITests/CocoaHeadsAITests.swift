//
//  CocoaHeadsAITests.swift
//  CocoaHeadsAITests
//
//  Created by Dimitri Brukakis on 03.10.25.
//

import Testing
import Foundation
import FoundationModels

// https://json-schema.org/understanding-json-schema/about
// https://platform.openai.com/docs/guides/structured-outputs

struct CocoaHeadsAITests {

    @Generable()
    struct MyStruct {
        let address: String
    }
    
    @Test func example() async throws {
        let myStruct = MyStruct(address: "Hello")
        print("\(myStruct)")

        let data = try JSONEncoder().encode(MyStruct.generationSchema)
        if let jsonString = String(data: data, encoding: .utf8) {
            print(jsonString)
        }
    }
    
    @Test func example2() async throws {
        let myStruct = MyStruct(address: "Hello")
        
        let schema: GenerationSchema = MyStruct.generationSchema
        print(String(describing: schema))
    }

}
