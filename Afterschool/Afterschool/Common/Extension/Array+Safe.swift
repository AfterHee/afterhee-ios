//
//  Array+Safe.swift
//  Afterschool
//
//  Created by BoMin Lee on 8/28/25.
//

extension Array {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
