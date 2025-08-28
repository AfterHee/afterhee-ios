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

/// 빈 날짜(주말 or 방학)에 MenuItem 존재하지 않는 DailyMenu 추가
extension Array where Element == DailyMenu {
    func ensuringPlaceholders(for baseDate: Date, calendar cal: Calendar = .seoul) -> [DailyMenu] {
        let start = cal.startOfDay(for: baseDate)
        let days: [Date] = [
            cal.date(byAdding: .day, value: -1, to: start)!,
            start,
            cal.date(byAdding: .day, value:  1, to: start)!
        ].map { cal.startOfDay(for: $0) }

        // 날짜 기준으로 이미 있는지 확인
        var byDay: [Date: DailyMenu] = [:]
        for m in self {
            byDay[cal.startOfDay(for: m.date)] = m
        }

        // 없으면 빈 DailyMenu 추가
        var out: [DailyMenu] = self
        for d in days where byDay[cal.startOfDay(for: d)] == nil {
            out.append(DailyMenu(date: d, items: []))
        }

        // 날짜 오름차순 정렬해서 반환
        out.sort { $0.date < $1.date }
        return out
    }
}
