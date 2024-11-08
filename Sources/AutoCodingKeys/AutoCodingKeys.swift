import AutoCodingKeysMacros

@attached(member, names: named(CodingKeys))
public macro AutoCodingKeys(customKeys: [String: String] = [:], keyCase: AutoCodingKeyCase = .snakeCase) = #externalMacro(module: "AutoCodingKeysMacros", type: "AutoCodingKeysMacro")
