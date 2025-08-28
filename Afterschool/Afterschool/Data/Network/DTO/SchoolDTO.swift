//
//  SchoolDTO.swift
//  Afterschool
//
//  Created by BoMin Lee on 8/28/25.
//

import Foundation

struct SchoolDTO: Codable, Hashable {
    let id: Int
    let sidoEduOfficeCode: String
    let sidoEduOfficeName: String
    let adminStandardCode: String
    let schoolName: String
    let roadAddress: String
    let roadDetailAddress: String
}
