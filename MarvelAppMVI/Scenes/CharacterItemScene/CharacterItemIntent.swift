//
//  CharacterItemIntent.swift
//  MarvelAppMVI
//
//  Created by Kohji Onaja on 26/04/24.
//

extension CharacterItemView {
    
    final class Intent {
        
        private weak var model: CharacterItemModelActions?
        var character: DisplayedCharacter
        init(model: CharacterItemModelActions? = nil, character: DisplayedCharacter) {
            self.model = model
            self.character = character
        }
        func doDisplayCharacter(){
            model?.presentCharacter(character: character)
        }
        func doFetchSeries()async{
            do {
                model?.presentLoading(true)
                print("xdddd cargando series")
                if NetworkMonitor.shared.isConnected{
                    let _ = try await MarvelNetworkGlobalActor.shared.getSeries(character.id)
                }
                let series: [SerieSwiftData] = await CharacterSwiftDataActorGlobal.shared.fetchSeries(character.id)
                let serieMapped: [DisplayedSerie] = series.map({ serie in
                    DisplayedSerie(id: serie.uid, title: serie.title, url: serie.url, imgData: serie.imgData, chracter: serie.character)
                })
                model?.presentSeries(series: serieMapped)
                
                model?.presentLoading(false)
            } catch {
                model?.presentLoading(false)
                print("Error fetching series: \(error)")
                
            }
        }


    }
    
}
