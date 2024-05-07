//
//  CharacterItemView.swift
//  MarvelAppMVI
//
//  Created by Kohji Onaja on 26/04/24.
//

import SwiftUI

struct CharacterItemView: View {
    
    typealias ContainerType = MVIContainer<CharacterItemView.Intent,CharacterItemModelState>
    
    @StateObject private var mviContainer: ContainerType
    
    private var model: CharacterItemModelState {
        return mviContainer.model
    }
    
    private var intent: CharacterItemView.Intent{
        return mviContainer.intent
    }
    
    var body: some View {
        ScrollView{
            VStack(alignment:.center){
                Text(mviContainer.model.displayCharacter.name)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                if let imgData = mviContainer.model.displayCharacter.imgData {
                    if let image = UIImage(data: imgData){
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                    }
                    
                }else{
                    AsyncImage(url: URL(string: mviContainer.model.displayCharacter.img_url)){ img in
                        img
                            .resizable()
                            .scaledToFit()
                    }placeholder: {
                        Color.black
                    }
                    .frame(width: 150, height: 150)
                }
                Text(mviContainer.model.displayCharacter.description)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .padding(.horizontal, 15)
            }
            Section(header:
                HStack{
                    Text("Lista de Episodios")
                        .font(.title2.bold())
                    Spacer()
                }
                .padding(.horizontal)
            ){
                if mviContainer.model.isLoading{
                    ProgressView()
                }else{
                    if !mviContainer.model.displaySeries.isEmpty  {
                        ScrollView(.horizontal, showsIndicators: false){
                            LazyHStack(alignment: .center, spacing: 0){
                                ForEach(mviContainer.model.displaySeries, id: \.id){ serie in
                                    VStack(alignment: .center){
                                        Spacer()
                                        if let imgData = serie.imgData {
                                            if let image = UIImage(data: imgData){
                                                Image(uiImage: image)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 200, height: 200)
                                            }
                                        }else{
                                            if let url = URL(string: serie.url){
                                                AsyncImage(url: url){ image in
                                                    image
                                                        .resizable()
                                                        .scaledToFit()
                                                    
                                                }placeholder: {
                                                    Color.black
                                                }
                                                .frame(width: 200, height: 200)
                                            }
                                        }
                                        Text(serie.title)
                                            .font(.title3.bold())
                                            .multilineTextAlignment(.center)
                                        Text(serie.chracter?.uid ?? "No encontre papa")
                                        
                                        Spacer()
                                    }
                                    .frame(width:300,height: 350)
                                    .cornerRadius(30)
                                    .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 5)
                                    .containerRelativeFrame(.horizontal)
                                    
                                }
                            }
                            .frame(height: 400)
                            
                        }
                        .scrollTargetBehavior(.paging)
                        .padding(.bottom, 20)
   
                    }else{
                        Text("No se encontraron Resultados")
                    }
                }
            }

        }
        .task{
            mviContainer.intent.doDisplayCharacter()
            await mviContainer.intent.doFetchSeries()
        }
    }
    
}

extension CharacterItemView {
    
    static func build(character: DisplayedCharacter) -> some View {
        let model = CharacterItemView.Model()
        let intent = CharacterItemView.Intent(model: model, character: character)
        let container = CharacterItemView.ContainerType(intent: intent,
                                                      model: model,
                                                      modelChangePublisher: model.objectWillChange)
        
        return CharacterItemView(mviContainer: container)
    }
    
}

#Preview {
    CharacterItemView.build(character: DisplayedCharacter(id: "", name: "String", description: "", img_url: "", imgData: nil))
}
