//
//  extensions.swift
//  Memorize
//
//  Created by Григорий Кривякин on 24.04.2021.
//

import Foundation
import SwiftUI

extension Color: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(self.description)
    }
}
