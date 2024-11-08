import AutoCodingKeys

@AutoCodingKeys
struct Example: Codable {
    let firstName: String
    let lastName: String
    let age: Int
}

