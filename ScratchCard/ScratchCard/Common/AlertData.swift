//
//  AlertData.swift
//  ScratchCard
//
//  Created by Ondrej Kondek on 05/11/2025.
//

import Foundation

struct AlertData: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let message: String?
}
