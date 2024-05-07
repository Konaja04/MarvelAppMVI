//
//  CharactersRouter.swift
//  MarvelAppMVI
//
//  Created by Kohji Onaja on 25/04/24.
//

import Foundation

enum CharactersRoute: Hashable{
    case detail(character: DisplayedCharacter)
}

final class CharactersRouter: SceneNavigationHandler<CharactersRoute> {
    
    //One function per destination
    //I.E 
    func showDetail(character: DisplayedCharacter){
        navigate(to: CharactersRoute.detail(character: character))
    }
}
