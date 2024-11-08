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
    
    func testBasicMacroCamelCaseKeys() throws {
#if canImport(AutoCodingKeys)
        // Define a struct with the `@AutoCodingKeys` macro applied.
        @AutoCodingKeys(keyCase: .camelCase)
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
        XCTAssertTrue(jsonString.contains("\"firstName\":\"Ali\""))
        XCTAssertTrue(jsonString.contains("\"lastName\":\"Gaza\""))
        XCTAssertTrue(jsonString.contains("\"age\":30"))
#else
        throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
    }
    
    func testBasicMacroSnakeCaseKeys() throws {
#if canImport(AutoCodingKeys)
        // Define a struct with the `@AutoCodingKeys` macro applied.
        @AutoCodingKeys(keyCase: .snakeCase)
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
    
    func testBasicMacroWithSnakeCaseAttributes() throws {
#if canImport(AutoCodingKeys)
        // Define a struct with the `@AutoCodingKeys` macro applied.
        @AutoCodingKeys
        struct Person: Codable {
            let first_name: String
            let last_name: String
            let age: Int
        }
        
        // Initialize an instance of the struct.
        let example = Person(
            first_name: "Ali",
            last_name: "Gaza",
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
    
    func testBasicMacroWithSnakeCaseAttributesWithCamelCaseKeys() throws {
#if canImport(AutoCodingKeys)
        // Define a struct with the `@AutoCodingKeys` macro applied.
        @AutoCodingKeys(keyCase: .camelCase)
        struct Person: Codable {
            let first_name: String
            let last_name: String
            let age: Int
        }
        
        // Initialize an instance of the struct.
        let example = Person(
            first_name: "Ali",
            last_name: "Gaza",
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
        XCTAssertTrue(jsonString.contains("\"firstName\":\"Ali\""))
        XCTAssertTrue(jsonString.contains("\"lastName\":\"Gaza\""))
        XCTAssertTrue(jsonString.contains("\"age\":30"))
#else
        throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
    }
    
    func testBasicMacroWithSnakeCaseAttributesWithSnakeCaseKeys() throws {
#if canImport(AutoCodingKeys)
        // Define a struct with the `@AutoCodingKeys` macro applied.
        @AutoCodingKeys(keyCase: .snakeCase)
        struct Person: Codable {
            let first_name: String
            let last_name: String
            let age: Int
        }
        
        // Initialize an instance of the struct.
        let example = Person(
            first_name: "Ali",
            last_name: "Gaza",
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
    
    func testMacroWithSpecialKeysWithCamelCaseKeys() throws {
#if canImport(AutoCodingKeys)

        @AutoCodingKeys(customKeys: ["productDescription": "description"], keyCase: .camelCase)
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
        XCTAssertTrue(jsonString.contains("\"productName\":\"iPhone 14 Pro Max\""))
        XCTAssertTrue(jsonString.contains("\"description\":\"Apple iPhone 14 Pro Max smartphone. Announced Sep 2022. Features 6.7″ display, Apple A16 Bionic chipset\""))
        XCTAssertTrue(jsonString.contains("\"price\":435.78"))
#else
        throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
    }
    
    func testMacroWithSpecialKeysWithSnakeCaseKeys() throws {
#if canImport(AutoCodingKeys)

        @AutoCodingKeys(customKeys: ["productDescription": "description"], keyCase: .snakeCase)
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
    
    func testMacroWithSpecialKeysAndSnakeCaseAttributes() throws {
#if canImport(AutoCodingKeys)

        @AutoCodingKeys(customKeys: ["product_description": "description"])
        struct Product: Codable {
            let product_name: String
            let product_description: String
            let price: Double
        }
        
        // Initialize an instance of the struct.
        let example = Product(
            product_name: "iPhone 14 Pro Max",
            product_description: "Apple iPhone 14 Pro Max smartphone. Announced Sep 2022. Features 6.7″ display, Apple A16 Bionic chipset",
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
    
    func testMacroWithSpecialKeysAndSnakeCaseAttributesWithCamelCaseKeys() throws {
#if canImport(AutoCodingKeys)

        @AutoCodingKeys(customKeys: ["product_description": "description"], keyCase: .camelCase)
        struct Product: Codable {
            let product_name: String
            let product_description: String
            let price: Double
        }
        
        // Initialize an instance of the struct.
        let example = Product(
            product_name: "iPhone 14 Pro Max",
            product_description: "Apple iPhone 14 Pro Max smartphone. Announced Sep 2022. Features 6.7″ display, Apple A16 Bionic chipset",
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
        XCTAssertTrue(jsonString.contains("\"productName\":\"iPhone 14 Pro Max\""))
        XCTAssertTrue(jsonString.contains("\"description\":\"Apple iPhone 14 Pro Max smartphone. Announced Sep 2022. Features 6.7″ display, Apple A16 Bionic chipset\""))
        XCTAssertTrue(jsonString.contains("\"price\":435.78"))
#else
        throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
    }
    
    func testMacroWithSpecialKeysAndSnakeCaseAttributesWithSnakeCaseKeys() throws {
#if canImport(AutoCodingKeys)

        @AutoCodingKeys(customKeys: ["product_description": "description"], keyCase: .snakeCase)
        struct Product: Codable {
            let product_name: String
            let product_description: String
            let price: Double
        }
        
        // Initialize an instance of the struct.
        let example = Product(
            product_name: "iPhone 14 Pro Max",
            product_description: "Apple iPhone 14 Pro Max smartphone. Announced Sep 2022. Features 6.7″ display, Apple A16 Bionic chipset",
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
