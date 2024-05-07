//
//  ComicsIntent.swift
//  MarvelAppMVI
//
//  Created by Kohji Onaja on 25/04/24.
//

extension ComicsView {
    
    final class Intent {
        
        private weak var model: ComicsModelActions?
        
        init(model: ComicsModelActions? = nil) {
            self.model = model
        }
        func doFetchComics() async{
            do {
                model?.presentLoading(true)
                if NetworkMonitor.shared.isConnected {
                    print("HAY INTERNET")
                    model?.presentNetwork(true)
                    let _ = try await MarvelNetworkGlobalActor.shared.getComics()
                }else{
                    model?.presentNetwork(false)
                    print("NO HAY INTERNET")
                }
                model?.presentLoading(false)
                let comics: [ComicSwiftData] = await ComicSwiftDataActorGlobal.shared.fetchEntities()
                model?.presentFetchedComics(comics: comics)
            } catch  {
                model?.presentLoading(false)
                model?.presentNetwork(false)
                print(error)
            }
        }
    }
    
}
