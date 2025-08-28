//
//  BaseResponseDTO.swift
//  Afterschool
//
//  Created by 임영택 on 8/24/25.
//

import Foundation

struct BaseResponseDTO<T: Codable>: Codable {
    let data: T
    let isError: Bool
    let message: String
}
