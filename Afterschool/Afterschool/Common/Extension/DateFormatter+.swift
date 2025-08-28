//
//  DateFormatter+.swift
//  Afterschool
//
//  Created by BoMin Lee on 8/28/25.
//

import Foundation

extension DateFormatter {
    static let yyyymmddKST: DateFormatter = {
        let f = DateFormatter()
        f.calendar = .init(identifier: .gregorian)
        f.timeZone = TimeZone(identifier: "Asia/Seoul")
        f.locale = .init(identifier: "ko_KR")
        f.dateFormat = "yyyyMMdd"
        return f
    }()
}
