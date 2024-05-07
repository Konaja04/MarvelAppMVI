//
//  ComicsRouter.swift
//  MarvelAppMVI
//
//  Created by Kohji Onaja on 25/04/24.
//

import Foundation

enum ComicsRoute: Hashable, Equatable{
    //I.E case home
    case ComicItem(DisplayedComic)
}

final class ComicsRouter: SceneNavigationHandler<ComicsRoute> {
    
    //One function per destination
    //I.E func showHome(){
    //  navigate(to: ComicsRoute.home)
    func showDetail(comic: DisplayedComic){
        navigate(to: ComicsRoute.ComicItem(comic))
    }
    //}
}
