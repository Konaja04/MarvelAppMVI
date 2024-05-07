//
//  CharactersIntent.swift
//  MarvelAppMVI
//
//  Created by Kohji Onaja on 25/04/24.
//

extension CharactersView {
    
    final class Intent {
        
        private weak var model: CharactersModelActions?
        
        init(model: CharactersModelActions? = nil) {
            self.model = model
        }
        func doFetchCharacters() async {
            do {
                model?.presentLoading(true)
                if NetworkMonitor.shared.isConnected{
                    print("HAY INTERNET")
                    model?.presentNetwork(true)
                    let _ = try await MarvelNetworkGlobalActor.shared.getCharacters()
                }else{
                    model?.presentNetwork(false)
                    print("NO HAY INTERNET")
                }
                model?.presentLoading(false)
                let characters: [CharacterSwiftData] = await CharacterSwiftDataActorGlobal.shared.fetchEntities()
                model?.presentFetchedCharacters(characters: characters)
            } catch {
                model?.presentLoading(false)
                model?.presentNetwork(false)
                print("Error fetching characters: \(error)")
            }
        }        
        

        
    }
    
}
