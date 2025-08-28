//
//  DailyMenu+UI.swift
//  Afterschool
//
//  Created by BoMin Lee on 8/28/25.
//

import Foundation

extension DailyMenu {
    var dateFormatted: String {
        let f = DateFormatter()
        f.locale = .init(identifier: "ko_KR")
        f.dateFormat = "M월 d일(E)"
        return f.string(from: date)
    }
}
