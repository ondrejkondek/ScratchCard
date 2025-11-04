//
//  Router.swift
//  ScratchCard
//
//  Created by Ondrej Kondek on 04/11/2025.
//

import SwiftUI

@Observable
final class Router {
    var path: [Route] = []
    
    func navigate(to route: Route) {
        path.append(route)
    }
    
    func goBack() {
        _ = path.popLast()
    }
    
    func reset() {
        path.removeAll()
    }
}
