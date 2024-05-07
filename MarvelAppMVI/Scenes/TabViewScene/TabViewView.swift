//
//  TabViewView.swift
//  MarvelAppMVI
//
//  Created by Kohji Onaja on 25/04/24.
//

import SwiftUI

struct TabViewView: View {
    
    @StateObject var charactersSceneRouter: CharactersSceneRouter
    @StateObject var comicsSceneRouter: ComicsSceneRouter

    init(){
        self._charactersSceneRouter = StateObject(wrappedValue: CharactersSceneRouter())
        self._comicsSceneRouter = StateObject(wrappedValue: ComicsSceneRouter())
    }
    var body: some View {
        TabView(){
            NavigationStack(path: $charactersSceneRouter.path){
                CharactersView.build(sceneAppRouter: self.charactersSceneRouter)
            }
            .tabItem {
                VStack{
                    Image(systemName: "house")
                    Text("Characters")
                }
            }
            NavigationStack(path: $comicsSceneRouter.path){
                ComicsView.build(sceneAppRouter: self.comicsSceneRouter)
            }.tabItem {
                VStack{
                    Image(systemName: "book")
                    Text("Comics")
                }
            }
        }
        .tabViewStyle(DefaultTabViewStyle())
        .background(Color.black)
        .accentColor(.red)
    }
    
}

