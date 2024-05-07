//
//  ComicsDestinationModifier.swift
//  MarvelAppMVI
//
//  Created by Kohji Onaja on 25/04/24.
//

import SwiftUI

public extension View {
    
    internal func withMainRouterForComics(sceneAppRouter: any SceneRouter) -> some View {
        self.navigationDestination(for: ComicsRoute.self) { destination in
            switch destination {
                //I.E case .home:
                //Text("Home")
            case .ComicItem(comic: let comic):
                ComicitemView.build(comic: comic)
                
            }
        }
    }
    
}
