//
//  NetworkManagable.swift
//  ScratchCard
//
//  Created by Ondrej Kondek on 05/11/2025.
//

import Foundation

protocol NetworkManagable {
    func request(_ urlRequest: URLRequest) async throws -> URLResponse
    func request<T: Decodable & Sendable>(_ urlRequest: URLRequest, body: T.Type) async throws -> T
}

