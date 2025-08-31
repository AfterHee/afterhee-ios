//
//  MealDTO.swift
//  Afterschool
//
//  Created by BoMin Lee on 8/28/25.
//

import Foundation

struct MealDTO: Codable, Hashable {
    let calInfo: String
    let dishNames: [String]
    let loadDtm: String
    let mlsvFgr: Int
    let mlsvFromYmd: String
    let mlsvToYmd: String
    let mlsvYmd: String
    let mmealScCode: String
    let mmealScNm: String
    let ntrInfo: String
    let orplcInfo: String
    let schoolAdminCode: String
    let schoolName: String
    let sidoEduOfficeCode: String
    let sidoEduOfficeName: String
}
