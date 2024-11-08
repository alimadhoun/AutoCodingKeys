import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest
import AutoCodingKeys


final class AutoCodingKeysTests: XCTestCase {
    
    func testBasicMacro() throws {
#if canImport(AutoCodingKeys)
        // Define a struct with the `@AutoCodingKeys` macro applied.
        @AutoCodingKeys
        struct Person: Codable {
            let firstName: String
            let lastName: String
            let age: Int
        }
        
        // Initialize an instance of the struct.
        let example = Person(
            firstName: "Ali",
            lastName: "Gaza",
            age: 30
        )
        
        // Encode the struct to JSON to verify if the generated CodingKeys are correct.
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .useDefaultKeys
        guard let jsonData = try? encoder.encode(example),
              let jsonString = String(data: jsonData, encoding: .utf8) else {
            XCTFail("Failed to encode Example struct to JSON.")
            return
        }
        
        // Verify that JSON keys are in snake_case
        XCTAssertTrue(jsonString.contains("\"first_name\":\"Ali\""))
        XCTAssertTrue(jsonString.contains("\"last_name\":\"Gaza\""))
        XCTAssertTrue(jsonString.contains("\"age\":30"))
#else
        throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
    }
    
    func testMacroWithSpecialKeys() throws {
#if canImport(AutoCodingKeys)

        @AutoCodingKeys(customKeys: ["productDescription": "description"])
        struct Product: Codable {
            let productName: String
            let productDescription: String
            let price: Double
        }
        
        // Initialize an instance of the struct.
        let example = Product(
            productName: "iPhone 14 Pro Max",
            productDescription: "Apple iPhone 14 Pro Max smartphone. Announced Sep 2022. Features 6.7″ display, Apple A16 Bionic chipset",
            price: 435.78
        )
        
        // Encode the struct to JSON to verify if the generated CodingKeys are correct.
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .useDefaultKeys
        guard let jsonData = try? encoder.encode(example),
              let jsonString = String(data: jsonData, encoding: .utf8) else {
            XCTFail("Failed to encode Example struct to JSON.")
            return
        }
        
        // Verify that JSON keys are in snake_case
        XCTAssertTrue(jsonString.contains("\"product_name\":\"iPhone 14 Pro Max\""))
        XCTAssertTrue(jsonString.contains("\"description\":\"Apple iPhone 14 Pro Max smartphone. Announced Sep 2022. Features 6.7″ display, Apple A16 Bionic chipset\""))
        XCTAssertTrue(jsonString.contains("\"price\":435.78"))
#else
        throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
    }
}
