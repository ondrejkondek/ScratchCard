//
//  AppConfiguration.swift
//  ScratchCard
//
//  Created by Ondrej Kondek on 05/11/2025.
//

struct AppConfiguration {
    static let environment: AppEnvironment = .acc
}

enum AppEnvironment {
    case acc
    case prod
    case mock
}
