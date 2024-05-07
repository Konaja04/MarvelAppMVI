//
//  CharactersDestinationModifier.swift
//  MarvelAppMVI
//
//  Created by Kohji Onaja on 25/04/24.
//

import SwiftUI

public extension View {
    
    internal func withMainRouterForCharacters(sceneAppRouter: any SceneRouter) -> some View {
        self.navigationDestination(for: CharactersRoute.self) { destination in
            switch destination {
                //I.E case .home:
                //Text("Home")
            case .detail(character: let character):
                CharacterItemView.build(character: character)
            }
        }
    }
    
}
