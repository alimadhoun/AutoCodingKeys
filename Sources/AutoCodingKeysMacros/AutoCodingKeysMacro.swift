import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct AutoCodingKeysMacro: MemberMacro {
    
    public static func expansion(of node: AttributeSyntax, providingMembersOf declaration: some DeclGroupSyntax, in context: some MacroExpansionContext) throws -> [DeclSyntax] {
        
        guard let structDecl = declaration.as(StructDeclSyntax.self) else {
            fatalError("The @AutoCodingKeys macro can only be applied to structs.")
        }
        
        // Generate CodingKeys enum
        let codingKeysEnum = try EnumDeclSyntax("enum CodingKeys: String, CodingKey") {
            for member in structDecl.memberBlock.members {
                if let variable = member.decl.as(VariableDeclSyntax.self),
                   let propertyName = variable.bindings.first?.pattern.as(IdentifierPatternSyntax.self)?.identifier.text {
                    
                    let snakeCaseName = convertToSnakeCase(propertyName)
                    try EnumCaseDeclSyntax("case \(raw: propertyName) = \"\(raw: snakeCaseName)\"")
                }
            }
        }
        
        return [DeclSyntax(codingKeysEnum)]
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
