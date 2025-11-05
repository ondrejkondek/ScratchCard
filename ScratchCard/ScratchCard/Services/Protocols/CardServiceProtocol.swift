//
//  CardServiceProtocol.swift
//  ScratchCard
//
//  Created by Ondrej Kondek on 05/11/2025.
//

import Foundation

protocol CardServiceProtocol {
    func generateId() async throws -> UUID
    func activateCard(code: UUID) async throws -> VersionResponse
}
