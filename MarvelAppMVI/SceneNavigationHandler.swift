//
//  SceneNavigationHandler.swift
//  MVISample
//
//  Created by Edgard Vargas on 21/04/24.
//

import Foundation

class SceneNavigationHandler<Route:Hashable>: ObservableObject{
    @Published var sceneAppRouter: any SceneRouter
    
    init(with sceneAppRouter: any SceneRouter) {
        self.sceneAppRouter = sceneAppRouter
    }
    
    func navigate(to target: Route) {
        sceneAppRouter.navigate(to: target)
    }
    
    func pop() {
        sceneAppRouter.pop()
    }
}
