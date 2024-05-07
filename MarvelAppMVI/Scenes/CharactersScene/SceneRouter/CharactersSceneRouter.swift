//
//  CharactersSceneRouter.swift
//  MarvelAppMVI
//
//  Created by Kohji Onaja on 25/04/24.
//

import Foundation
import SwiftUI

public class CharactersSceneRouter: SceneRouter {
    @Published public var path: NavigationPath
    
    required public init(with path: NavigationPath = NavigationPath()) {
        self.path = path
    }
    
    public func navigate(to destination: any Hashable) {
        path.append(destination)
    }
    
    public func pop() {
        path.removeLast()
    }
    
}
