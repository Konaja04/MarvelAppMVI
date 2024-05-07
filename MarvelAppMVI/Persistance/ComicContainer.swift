//
//  ComicSwiftData.swift
//  MarvelAppMVI
//
//  Created by Kohji Onaja on 30/04/24.
//

import Foundation
import SwiftData
@globalActor struct ComicSwiftDataActorGlobal{
    static let shared = ComicSwiftDataActor()
}

actor ComicSwiftDataActor: ModelActor{
    
   let modelContainer: ModelContainer
   let modelContext: ModelContext
   let modelExecutor: any ModelExecutor
   
    init(){
        print("INSTANCIA DE MODELO DE SWIFTDATA DE COMIC")
        self.modelContainer = try! ModelContainer(for: ComicSwiftData.self, configurations: ModelConfiguration("Comic"))
        self.modelContext = ModelContext(modelContainer)
        self.modelContext.autosaveEnabled = false
        modelExecutor = DefaultSerialModelExecutor(modelContext: modelContext)
        if let url = modelContainer.configurations.first?.url.path(percentEncoded: false){
            print(url)
        }
    }
    func save() {
        do {
            try modelContext.save()
        } catch  {
            print(error)
        }
    }
    
    func insert<T: PersistentModel>(entity: T) {
        modelContext.insert(entity)
        
    }
    
    func remove<T: PersistentModel>(entity: T) {
        modelContext.delete(entity)
        do {
            try modelContext.save()
        } catch  {
            print(error)
        }
    }
    
    func removeEntitiesWithNoChangesToSave<T: PersistentModel>(entities: [T]) {
        
        entities.filter({!$0.hasChanges}).forEach({
            item in
//            print("----------removed", item.persistentModelID)
            remove(entity: item)
        })
        
    }
    
    func fetchEntities<T: PersistentModel>() -> [T] {
        do {
            let predicate:Predicate<T>? = nil
            let fetchDescriptor = FetchDescriptor<T>(predicate: predicate)
            let entities: [T] = try modelContext.fetch(fetchDescriptor)
            return entities
        } catch {
            print(error.localizedDescription)
            return []
        }
        
    }
    func fetchCreators(_ uid: String)->[CreatorSwiftData]{
        do {
            let fetchDescriptor = ComicSwiftData.fetchDescriptorEntityById(uid: uid)
            let entities = try modelContext.fetch(fetchDescriptor)
            return entities.first?.creators ?? []
        } catch  {
            print(error.localizedDescription)
            return []
        }
    }
    func fetchEntityByUid<T:UniquedObject>(uid: String) -> T? {
        
        do {
            let fetchDescriptor = T.fetchDescriptorEntityById(uid: uid)
            
            let entities = try modelContext.fetch(fetchDescriptor)
            
            return entities.first
        } catch  {
            print(error.localizedDescription)
            return nil
        }
        
    }
    
    func fetchSingleOrCreate<T:UniquedObject>(uid: String, entity: T) -> T? {
        return fetchEntityByUid(uid: uid) ?? createEntity(entity: entity, uid: uid)
    }
    
    
    func createEntity<T: UniquedObject>(entity: T, uid: String) -> T? {
        modelContext.insert(entity)
        do {
            let fetchDescriptor = T.fetchDescriptorEntityById(uid: uid)
            let entities = try modelContext.fetch(fetchDescriptor)
            
            return entities.first!
        } catch  {
            print(error.localizedDescription)
            return nil
        }
    }
    
}
