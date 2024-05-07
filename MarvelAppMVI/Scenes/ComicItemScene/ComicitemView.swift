//
//  ComicitemView.swift
//  MarvelAppMVI
//
//  Created by Kohji Onaja on 26/04/24.
//

import SwiftUI

struct ComicitemView: View {
    
    typealias ContainerType = MVIContainer<ComicitemView.Intent,ComicitemModelState>
    
    @StateObject private var mviContainer: ContainerType
    
    private var model: ComicitemModelState {
        return mviContainer.model
    }
    
    private var intent: ComicitemView.Intent{
        return mviContainer.intent
    }
    
    var body: some View {
        ScrollView{
            VStack(alignment: .center){
                Text(model.displayedComic.title)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                if let imgData = mviContainer.model.displayedComic.imgData {
                    if let image = UIImage(data: imgData){
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                    }
                    
                }else{
                    AsyncImage(url: URL(string: mviContainer.model.displayedComic.img_url)){ img in
                        img
                            .resizable()
                            .scaledToFit()
                    }placeholder: {
                        Color.black
                    }
                    .frame(width: 150, height: 150)
                }
                Text(model.displayedComic.description)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .padding(.horizontal, 10)
                
            }
            Section(header:
                        HStack{
                Text("Creadores")
                    .font(.title2.bold())
                Spacer()
            }
            ){
                if mviContainer.model.isLoading{
                    ProgressView()
                }else{
                    if !mviContainer.model.displayedCreators.isEmpty  {
                        ForEach(mviContainer.model.displayedCreators, id: \.id){ creator in
                            HStack{
                                if let imgData = creator.imgData{
                                    if let image = UIImage(data: imgData){
                                        Image(uiImage: image)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 50)
                                    }
                                }else{
                                    if let url = URL(string: creator.url){
                                        AsyncImage(url: url){ image in
                                            image
                                                .resizable()
                                                .scaledToFit()
                                            
                                        }placeholder: {
                                            Color.black
                                        }
                                        .frame(width: 50, height: 50)
                                    }
                                }
                                VStack(alignment: .leading){
                                    Text(creator.name)
                                        .font(.title3.bold())
                                    Text(creator.comic?.uid ?? "No encontre papa")
                                }
                                Spacer()
                            }
                        }
                    }else{
                        Text("No se encontraron Resultados")
                    }
                }
            }.padding()
            
        }.task {
            mviContainer.intent.doDisplayComic()
            await mviContainer.intent.doFetchCreators()
        }
    }
    
}

extension ComicitemView {
    
    static func build(comic: DisplayedComic) -> some View {
        let model = ComicitemView.Model()
        let intent = ComicitemView.Intent(model: model,comic: comic)
        let container = ComicitemView.ContainerType(intent: intent,
                                                      model: model,
                                                      modelChangePublisher: model.objectWillChange)
        
        return ComicitemView(mviContainer: container)
    }
    
}

#Preview {
    ComicitemView.build(comic: DisplayedComic(id: "", title: "", description: "", img_url: "", imgData: nil))
}
