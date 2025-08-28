//
//  Date+.swift
//  Afterschool
//
//  Created by BoMin Lee on 8/28/25.
//

import Foundation

extension Date {
    var dateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
}
