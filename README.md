# AutoCodingKeysMacro

`AutoCodingKeysMacro` is a Swift macro that automatically generates `CodingKeys` enums for `Codable` structs. It allows you to convert property names from camelCase to snake_case (or another specified case) automatically, with options for custom mappings of specific keys.

## Installation

To use `AutoCodingKeysMacro` in your project, add it as a Swift Package dependency.

1. Open your project in Xcode.
2. Go to `File` > `Add Packages...`.
3. Enter the following Git URL for the package:
```https://github.com/alimadhoun/AutoCodingKeys.git```

## Usage

To use `AutoCodingKeysMacro`, simply add the `@AutoCodingKeys` attribute to any `Codable` struct. This will automatically generate a `CodingKeys` enum, mapping struct properties to a specified case style (snake_case by default).

### Example

Here's a quick example:

```swift
import AutoCodingKeysMacro

@AutoCodingKeys
struct Person: Codable {
 let firstName: String
 let lastName: String
 let age: Int
}
```
After applying the @AutoCodingKeys macro, the code will expand to:

```swift
struct Person: Codable {
    let firstName: String
    let lastName: String
    let age: Int
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case age = "age"
    }
}
```

## Custom Key Mappings
You can also specify custom keys for certain properties by passing a dictionary to the `@AutoCodingKeys` macro. For instance, if a property’s JSON key is a reserved keyword or has a different naming convention, you can set a custom mapping.
```swift
@AutoCodingKeys(customKeys: ["productDescription": "description"])
struct Product: Codable {
    let productName: String
    let productDescription: String
    let price: Double
}
```
The macro will generate:
```swift
@AutoCodingKeys(customKeys: ["productDescription": "description"])
struct Product: Codable {
    let productName: String
    let productDescription: String
    let price: Double
    
    enum CodingKeys: String, CodingKey {
        case productName = "product_name"
        case productDescription = "description"
        case price = "price"
    }
}
```

## Changing the Case Style
You can also specify the case style for all keys in the struct. By default, the macro uses snake_case, but you can set it to camelCase if needed.
Example
```swift
@AutoCodingKeys(keyCase: .camelCase)
struct Person: Codable {
    let first_name: String
    let last_name: String
    let age: Int
}
```
With `keyCase` set to `.camelCase`, the generated CodingKeys enum will use camelCase:
```swift
struct Person: Codable {
    let first_name: String
    let last_name: String
    let age: Int
    
    enum CodingKeys: String, CodingKey {
        case first_name = "firstName"
        case last_name = "lastName"
        case age
    }
}
```
Supported Key Cases
Currently, `AutoCodingKeysMacr`o supports the following case styles:
- `.snakeCase` (default)
- `.camelCase`

## License
This project is licensed under the MIT License.
