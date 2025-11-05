//
//  ApiService.swift
//  ScratchCard
//
//  Created by Ondrej Kondek on 04/11/2025.
//

import Foundation

enum ApiEndpoints {
    case activate(code: UUID)

    var methodType: MethodType {
        switch self {
        case .activate:
            return .GET
        }
    }
    
    var path: String {
        switch self {
        case .activate:
            return "/version"
        }
    }

    var queryItems: [URLQueryItem]? {
        switch self {
        case .activate(let code):
            return [URLQueryItem(name: "code", value: code.uuidString)]
        }
    }

    var url: URL {
        var components = URLComponents()
        components.scheme = NetworkConfiguration.scheme
        components.host = NetworkConfiguration.host
        components.path = path
        components.queryItems = queryItems

        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        return url
    }
    
    var request: URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = methodType.rawValue
        return request
    }
}

enum MethodType: String {
    case GET
    case POST
    case DELETE
    case PUT
}

