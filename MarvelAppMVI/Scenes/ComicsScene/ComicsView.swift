//
//  ComicsView.swift
//  MarvelAppMVI
//
//  Created by Kohji Onaja on 25/04/24.
//

import SwiftUI

struct ComicsView: View {
    
    typealias ContainerType = MVIContainer<ComicsView.Intent,ComicsModelState>
    
    @StateObject private var mviContainer: ContainerType
    var router: ComicsRouter
    
    private var model: ComicsModelState {
        return mviContainer.model
    }
    
    private var intent: ComicsView.Intent {
        return mviContainer.intent
    }
     
    var body: some View {
        VStack{
            if mviContainer.model.isLoading{
                ProgressView()
            }else{
                if !mviContainer.model.isNetworkAvailable{
                    Text("No hay internet")
                        .font(.title3.bold())
                        .foregroundColor(.white)
                        .frame(maxWidth:.infinity, maxHeight: 30)
                        .background(.red)
                }
                    List{
                        ForEach(model.displayedFectchedComics, id: \.id){ item in
                            HStack{
                                AsyncImage(url: URL(string: item.img_url)){ img in
                                    img
                                        .resizable()
                                        .scaledToFit()
                                }placeholder: {
                                    Color.black
                                }
                                .frame(width: 100, height: 90)
                                Text(item.title)
                            }
                            .onTapGesture {
                                router.showDetail(comic: item)
                            }
                        }
                    }
                    .refreshable(action: {
                        Task {
                            await mviContainer.intent.doFetchComics()
                        }
                    })
                    .listStyle(.plain)
            }

            
        }
        .onFirstAppear {
            Task{
                await mviContainer.intent.doFetchComics()
            }
        }
        .modifier(NavigationConfig(sceneRouter: router.sceneAppRouter))
    
    }
    
}

//Navigation and toolbar config
extension ComicsView {
    
    struct NavigationConfig: ViewModifier{
        
        var sceneRouter: any SceneRouter
        
        func body(content: Content) -> some View {
            content
                .withMainRouterForComics(sceneAppRouter: sceneRouter)
                .modifier(ToolbarConfig())
        }
        
    }
    
    struct ToolbarConfig: ViewModifier{
        
        func body(content: Content) -> some View {
            content
        }
        
    }
}

extension ComicsView {
    
    static func build(sceneAppRouter: any SceneRouter) -> some View {
        let model = ComicsView.Model()
        let intent = ComicsView.Intent(model: model)
        let container = ComicsView.ContainerType(intent: intent,
                                                      model: model,
                                                      modelChangePublisher: model.objectWillChange)
        
        return ComicsView(mviContainer: container,
                                            router: ComicsRouter(with: sceneAppRouter))
    }
    
}
