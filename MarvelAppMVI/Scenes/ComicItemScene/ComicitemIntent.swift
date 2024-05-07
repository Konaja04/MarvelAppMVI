//
//  ComicitemIntent.swift
//  MarvelAppMVI
//
//  Created by Kohji Onaja on 26/04/24.
//

extension ComicitemView {
    
    final class Intent {
        
        private weak var model: ComicitemModelActions?
        private var comic: DisplayedComic
        init(model: ComicitemModelActions? = nil, comic: DisplayedComic) {
            self.model = model
            self.comic = comic
        }
        func doDisplayComic(){
            model?.presentComic(comic: comic)
        }
        
        func doFetchCreators()async{
            do {
                model?.presentLoading(true)
                print("xdddd cargando series")
                if NetworkMonitor.shared.isConnected{
                    let _ = try await MarvelNetworkGlobalActor.shared.getCreators(comic.id)
                }
                let creators: [CreatorSwiftData] = await ComicSwiftDataActorGlobal.shared.fetchCreators(comic.id)
                let creatorsMapped: [DisplayedCreator] = creators.map({ creator in
                    DisplayedCreator(id: creator.uid, name: creator.name, url: creator.url, imgData: creator.imgData, comic: creator.comic)
                })
                print(creatorsMapped)
                model?.presentCreators(creators:creatorsMapped)
                
                model?.presentLoading(false)
            } catch {
                model?.presentLoading(false)
                print("Error fetching series: \(error)")
            }
        }
    }
    
}
