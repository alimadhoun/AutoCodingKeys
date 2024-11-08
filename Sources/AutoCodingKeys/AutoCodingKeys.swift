
@attached(member, names: named(CodingKeys))
public macro AutoCodingKeys(customKeys: [String: String] = [:]) = #externalMacro(module: "AutoCodingKeysMacros", type: "AutoCodingKeysMacro")
