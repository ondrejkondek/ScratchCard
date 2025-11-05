//
//  ServiceFactory.swift
//  ScratchCard
//
//  Created by Ondrej Kondek on 05/11/2025.
//

import Foundation

final class ServiceFactory {
    static func make<T: ServiceProvider>(type: T.Type) -> T {
        let environment = AppConfiguration.environment
        switch environment {
        case .acc:
            return T(networkManager: NetworkManager())
        case .prod:
            fatalError("Not implemented")
        case .mock:
            fatalError("Not implemented")
        }
    }
}
