import AutoCodingKeys

@AutoCodingKeys
struct Person: Codable {
    let firstName: String
    let lastName: String
    let age: Int
}

@AutoCodingKeys(customKeys: ["productDescription": "description"])
struct Product: Codable {
    let productName: String
    let productDescription: String
    let price: Double
}
