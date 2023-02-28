//
//  Codable++.swift
//  
//
//  Created by xuanbach on 22/07/2022.
//

import Foundation

public extension Encodable {
    subscript(key: String) -> Any? {
        return dictionary[key]
    }

    var dictionary: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: JSONEncoder().encode(self))) as? [String: Any] ?? [:]
    }

    // encode from object to data
    func encode() -> Data? {
        return try? JSONEncoder().encode(self)
    }

    // encode from object to jsonString "[String: Any]"
    func encodeToJsonString() -> String? {
        if let data = self.encode(),
           let jsonString = String(data: data, encoding: .utf8) {
            return jsonString
        }

        return nil
    }
}

extension Decodable {
    // swiftlint:disable:next type_name
    typealias T = Self

    init(from: Any) throws {
        let data = try JSONSerialization.data(withJSONObject: from, options: .prettyPrinted)
        let decoder = JSONDecoder()
        self = try decoder.decode(Self.self, from: data)
    }

    // decode from data to object
    static func decode(data: Data) -> T? {
        return try? JSONDecoder().decode(T.self, from: data)
    }

    // decode from jsonString "[String: Any]" to object(T)
    static func decode(jsonString: String) -> T? {
        if let data = jsonString.data(using: .utf8) {
            return decode(data: data)
        }
        return nil
    }
}
