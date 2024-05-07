//
//  CharactersView.swift
//  MarvelAppMVI
//
//  Created by Kohji Onaja on 25/04/24.
//

import SwiftUI

struct CharactersView: View {
    
    typealias ContainerType = MVIContainer<CharactersView.Intent,CharactersModelState>
    
    @StateObject private var mviContainer: ContainerType
    var router: CharactersRouter
    
    private var model: CharactersModelState {
        return mviContainer.model
    }
    
    private var intent: CharactersView.Intent {
        return mviContainer.intent
    }
     
    var body: some View {
        VStack{
            if mviContainer.model.isLoading{
                ProgressView()
            }else{
                VStack{
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack(spacing: 10){
                                ForEach(mviContainer.model.displayFetchedCharacters, id: \.id){ item in
                                    VStack(alignment: .center){
                                        AsyncImage(url: URL(string: item.img_url)){ img in
                                            img
                                                .resizable()
                                                .scaledToFit()
                                        }placeholder: {
                                            Color.black
                                        }
                                        .frame(width: 100, height: 90)
                                        .clipShape(Circle())
                                        Text(item.name.prefix(10))
                                            
                                    }
                                    .onTapGesture {
                                        router.showDetail(character: item)
                                    }
                                }
                            }
                        }
                    if !mviContainer.model.isNetworkAvailable{
                        Text("No hay Conexión")
                            .font(.title3.bold())
                            .foregroundColor(.white)
                            .frame(maxWidth:.infinity, maxHeight: 30)
                            .background(.red)
                    }                    

                    List{
                        ForEach(mviContainer.model.displayFetchedCharacters, id: \.id){ item in
                            HStack(alignment: .center){
                                AsyncImage(url: URL(string: item.img_url)){ img in
                                    img
                                        .resizable()
                                        .scaledToFit()
                                }placeholder: {
                                    Color.black
                                }
                                .frame(width: 100, height: 90)
                                Text(item.name)
                            }
                            .onTapGesture {
                                router.showDetail(character: item)
                            }
                        }
                    }
                    .refreshable(action: {
                        Task {
                            print("REFRESCANDOX")
                            await mviContainer.intent.doFetchCharacters()
                        }
                    })
                    .listStyle(.plain)
                }
                .padding(1)
            }
        }
        .onFirstAppear {
            Task{
                await mviContainer.intent.doFetchCharacters()
            }
        }
        .modifier(NavigationConfig(sceneRouter: router.sceneAppRouter))
    }
    
}

//Navigation and toolbar config
extension CharactersView {
    
    struct NavigationConfig: ViewModifier{
        
        var sceneRouter: any SceneRouter
        
        func body(content: Content) -> some View {
            content
                .withMainRouterForCharacters(sceneAppRouter: sceneRouter)
                .modifier(ToolbarConfig())
        }
        
    }
    
    struct ToolbarConfig: ViewModifier{
        
        func body(content: Content) -> some View {
            content
        }
        
    }
}

extension CharactersView {
    
    static func build(sceneAppRouter: any SceneRouter) -> some View {
        let model = CharactersView.Model()
        let intent = CharactersView.Intent(model: model)
        let container = CharactersView.ContainerType(intent: intent,
                                                      model: model,
                                                      modelChangePublisher: model.objectWillChange)
        
        return CharactersView(mviContainer: container,
                                            router: CharactersRouter(with: sceneAppRouter))
    }
    
}

