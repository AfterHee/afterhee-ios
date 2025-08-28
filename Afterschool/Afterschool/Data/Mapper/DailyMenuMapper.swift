//
//  DailyMenuMapper.swift
//  Afterschool
//
//  Created by BoMin Lee on 8/28/25.
//

import Foundation

enum DailyMenuMapper {
    static func map(_ dtos: [MealDTO]) -> [DailyMenu] {
        let cal = Calendar.seoul
        let formatter = DateFormatter.yyyymmddKST
        
        // 날짜 문자열로 그룹핑
        let grouped = Dictionary(grouping: dtos, by: { $0.mlsvYmd })
        
        var result: [DailyMenu] = []
        result.reserveCapacity(grouped.count)
        
        for (ymd, dayDtos) in grouped {
            guard let date = formatter.date(from: ymd) else { continue }
            var names: [String] = []
            for dto in dayDtos {
                for raw in dto.dishNames {
                    let trimmed = raw.trimmingCharacters(in: .whitespacesAndNewlines)
                    if !trimmed.isEmpty {
                        names.append(trimmed)
                    }
                }
            }
            
            let items = names.map { MenuItem(name: $0) }
            result.append(DailyMenu(date: cal.startOfDay(for: date), items: items))
        }
        
        // 날짜 오름차순
        result.sort { $0.date < $1.date }
        return result
    }
}
