//
//  AppConfiguration.swift
//  Afterschool
//
//  Created by BoMin Lee on 8/24/25.
//

import Foundation

enum AppConfigurationError: Error {
    case missingOrInvalidBaseURL
}

struct AppConfiguration {
    static var baseURL: URL {
        guard let s = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String,
              let url = URL(string: s) else {
            preconditionFailure("BASE_URL is missing or invalid in Info.plist")
        }
        return url
    }
}
