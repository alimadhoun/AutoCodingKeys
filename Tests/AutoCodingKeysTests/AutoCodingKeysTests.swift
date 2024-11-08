import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest
import AutoCodingKeys


final class AutoCodingKeysTests: XCTestCase {
    func testMacro() throws {
#if canImport(AutoCodingKeys)
        // Define a struct with the `@AutoCodingKeys` macro applied.
        @AutoCodingKeys
        struct Example: Codable {
            let firstName: String
            let lastName: String
            let age: Int
        }
        
        // Initialize an instance of the struct.
        let example = Example(firstName: "Ali", lastName: "Gaza", age: 30)
        
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
}
