//
//  MockCardService.swift
//  ScratchCard
//
//  Created by Ondrej Kondek on 06/11/2025.
//

import Foundation
@testable import ScratchCard

final class MockCardService: CardServiceProtocol {
    var generateResult: Result<UUID, Error> = .success(UUID())
    var generateDelayNanoseconds: UInt64 = 0
    var activateResult: Result<VersionResponse, Error> = .success(VersionResponse(ios: "7.0"))
    var activateDelayNanoseconds: UInt64 = 0
    
    func generateId() async throws -> UUID {
        if generateDelayNanoseconds > 0 {
            try? await Task.sleep(nanoseconds: generateDelayNanoseconds)
        }
        return try generateResult.get()
    }
    
    func activateCard(code: UUID) async throws -> VersionResponse {
        if activateDelayNanoseconds > 0 {
            try? await Task.sleep(nanoseconds: activateDelayNanoseconds)
        }
        return try activateResult.get()
    }
}
