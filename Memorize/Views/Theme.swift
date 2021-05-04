//
//  Theme.swift
//  Memorize
//
//  Created by Григорий Кривякин on 02.05.2021.
//

import Foundation
import SwiftUI

struct Theme: Encodable, Hashable, Identifiable {
    var name: String
    var emojis: Array<String>
    var numberOfPairs: Int
    var color: Color
    var id: UUID
    
    
    var json: Data? {
        return try? JSONEncoder().encode(self)
    }
    
    init (name: String, emojis: Array<String>, numberOfPairs: Int, color: Color, id: UUID? = nil) {
        self.name = name
        self.color = color
        self.numberOfPairs = numberOfPairs
        self.emojis = Array<String>(emojis[0..<self.numberOfPairs])
        self.id = id ?? UUID()
    }
}
