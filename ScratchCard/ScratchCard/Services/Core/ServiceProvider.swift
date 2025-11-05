//
//  ServiceProvider.swift
//  ScratchCard
//
//  Created by Ondrej Kondek on 05/11/2025.
//

protocol ServiceProvider {
    var networkManager: NetworkManagable { get }
    init(networkManager: NetworkManagable)
}
