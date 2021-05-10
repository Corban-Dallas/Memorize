//
//  extensions.swift
//  Memorize
//
//  Created by Григорий Кривякин on 24.04.2021.
//

import Foundation
import SwiftUI



extension Color: Codable {
    public init(from decoder: Decoder) throws {
        var description = try decoder.unkeyedContainer()
        let name = try description.decode(String.self)
        self.init(colorName: name)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(self.description)
    }
    
    static let namedColors: [String: Color] = [
        "black": Color.black,
        "red": Color.red,
        "green": Color.green,
        "blue": Color.blue,
        "orange": Color.orange,
        "pink": Color.pink,
        "yellow": Color.yellow
    ]
    init(colorName: String) {
        self = Color.namedColors[colorName] ?? Color.black
    }
}

extension Dictionary where Key == String, Value == Color {
    public var keysArray: [String] {
        var kArray = [String]()
        keys.forEach { kArray.append($0) }
        return kArray
    }
    
    
}
