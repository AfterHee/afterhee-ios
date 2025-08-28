//
//  MainServerTarget.swift
//  Afterschool
//
//  Created by 임영택 on 8/24/25.
//  Edited by BoMin Lee on 8/28/25.
//

import Foundation
import Moya

enum MainServerTarget {
    case getSchool(keyword: String)
    case getMeal(eduOfficeCode: String, schoolCode: String, from: String, to: String)
    case suggest(category: String, skipMenus: [String])
}

extension MainServerTarget: TargetType {
    var baseURL: URL {
        AppConfiguration.baseURL
    }
    
    var path: String {
        switch self {
        case .getSchool:
            "/schools"
        case .getMeal:
            "/schools/meals/"
        case .suggest:
            "/suggest"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getSchool, .getMeal:
            .get
        case .suggest:
            .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getSchool(let keyword):
                .requestParameters(parameters: ["keyword": keyword], encoding: URLEncoding.queryString)
        case .getMeal(let eduOfficeCode, let schoolCode, let from, let to):
                .requestParameters(parameters: ["eduOfficeCode": eduOfficeCode, "schoolCode": schoolCode, "from": from, "to": to], encoding: URLEncoding.queryString)
        case .suggest(let category, let skipMenus):
                .requestParameters(parameters: ["category": category, "skipMenus": skipMenus], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
