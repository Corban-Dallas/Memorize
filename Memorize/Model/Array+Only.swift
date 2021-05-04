//
//  Array+Only.swift
//  Memorize
//
//  Created by Григорий Кривякин on 04.03.2021.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
