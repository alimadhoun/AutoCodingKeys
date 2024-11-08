import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct AutoCodingKeysMacro: MemberMacro {
    
    public static func expansion(of node: AttributeSyntax, providingMembersOf declaration: some DeclGroupSyntax, in context: some MacroExpansionContext) throws -> [DeclSyntax] {
        
        guard let structDecl = declaration.as(StructDeclSyntax.self) else {
            fatalError("The @AutoCodingKeys macro can only be applied to structs.")
        }
        
        // Retrieve custom key mappings from the macro's arguments
        let customKeys = extractCustomKeys(from: node)
        
        let keyCaseOption = extractKeyCase(from: node) ?? .snakeCase
        
        // Generate CodingKeys enum
        let codingKeysEnum = try EnumDeclSyntax("enum CodingKeys: String, CodingKey") {
            for member in structDecl.memberBlock.members {
                if let variable = member.decl.as(VariableDeclSyntax.self),
                   let propertyName = variable.bindings.first?.pattern.as(IdentifierPatternSyntax.self)?.identifier.text {
                    
//                    var codingKeyName: String = ""
                    if let customKey = customKeys[propertyName] {
//                        codingKeyName = customKey
                        try EnumCaseDeclSyntax("case \(raw: propertyName) = \"\(raw: customKey)\"")
                    } else {
                        // Determine coding key format based on keyCaseOption
                        if keyCaseOption == .camelCase {
//                            codingKeyName = convertToCamelCase(propertyName)
                            try EnumCaseDeclSyntax("case \(raw: propertyName) = \"\(raw: convertToCamelCase(propertyName))\"")
                        } else {
                            try EnumCaseDeclSyntax("case \(raw: propertyName) = \"\(raw: convertToSnakeCase(propertyName))\"")
//                            codingKeyName = convertToSnakeCase(propertyName)
                        }
                    }
                    
                    
                }
            }
        }
        
        return [DeclSyntax(codingKeysEnum)]
    }
    
    // Helper function to parse customKeys argument from the macro
    private static func extractCustomKeys(from node: AttributeSyntax) -> [String: String] {
        var customKeys: [String: String] = [:]
        
        if let argumentList = node.arguments?.as(LabeledExprListSyntax.self) {
            for element in argumentList {
                if let label = element.label?.text, label == "customKeys",
                   let dictionaryLiteral = element.expression.as(DictionaryExprSyntax.self),
                   let dictionaryElements = dictionaryLiteral.content.as(DictionaryElementListSyntax.self) {
                    
                    for entry in dictionaryElements {
                        if let keyExpr = entry.key.as(StringLiteralExprSyntax.self),
                           let key = keyExpr.segments.first?.description,
                           let valueExpr = entry.value.as(StringLiteralExprSyntax.self),
                           let value = valueExpr.segments.first?.description {
                            customKeys[key] = value
                        }
                    }
                }
            }
        }
        
        return customKeys
    }
    
    // Helper function to parse keyCase argument from the macro
    private static func extractKeyCase(from node: AttributeSyntax) -> AutoCodingKeyCase? {
        if let argumentList = node.arguments?.as(LabeledExprListSyntax.self) {
            for element in argumentList {
                if let label = element.label?.text, label == "keyCase",
                   let caseLiteral = element.expression.as(MemberAccessExprSyntax.self) {
                    let caseValue = caseLiteral.declName.baseName.text
                    return AutoCodingKeyCase(rawValue: caseValue)
                }
            }
        }
        return nil
    }
    
    // Helper function to convert snake_case to camelCase
    private static func convertToCamelCase(_ snakeCase: String) -> String {
        let components = snakeCase.split(separator: "_")
        guard components.count > 1 else {
            return snakeCase
        }
        
        let fistComponent = components.first?.description.lowercased() ?? ""
        let capitalizedComponents = components
            .dropFirst()
            .map({ $0.capitalized })
        
        return fistComponent + capitalizedComponents.joined()
    }
    
    private static func convertToSnakeCase(_ camelCase: String) -> String {
        // Converts camelCase to snake_case
        var snakeCase = ""
        for character in camelCase {
            if character.isUppercase {
                snakeCase.append("_")
                snakeCase.append(character.lowercased())
            } else {
                snakeCase.append(character)
            }
        }
        return snakeCase
    }
}

@main
struct AutoCodingKeysPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        AutoCodingKeysMacro.self,
    ]
}

public enum AutoCodingKeyCase: String {
    case snakeCase
    case camelCase
}
