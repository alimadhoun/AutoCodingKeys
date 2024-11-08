import AutoCodingKeys

//
//@AutoCodingKeys
//struct Person: Codable {
//    let firstName: String
//    let lastName: String
//    let age: Int
//}

@AutoCodingKeys(keyCase: .camelCase)
struct Person: Codable {
    let first_name: String
    let last_name: String
    let age: Int
}

@AutoCodingKeys(keyCase: .camelCase)
struct PersonWithCamelCaseKeys: Codable {
    let firstName: String
    let lastName: String
    let age: Int
}

@AutoCodingKeys
struct PersonWithSnakeCaseAttributes: Codable {
    let first_name: String
    let last_name: String
    let age: Int
}

@AutoCodingKeys(customKeys: ["productDescription": "description"])
struct Product: Codable {
    let productName: String
    let productDescription: String
    let price: Double
}

@AutoCodingKeys(customKeys: ["productDescription": "description"])
struct ProductWithSnakeCaseAttrTests: Codable {
    let product_name: String
    let product_description: String
    let price: Double
}
