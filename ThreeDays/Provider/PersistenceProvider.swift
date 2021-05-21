//
//  PersistenceService.swift
//  ThreeDays
//
//  Created by koen.chen on 2021/5/21.
//

import CoreData

struct PersistenceProvider {
    static let shared = PersistenceProvider()
    
    static var preview: PersistenceProvider = {
        let result = PersistenceProvider(inMemory: true)
        let viewContext = result.container.viewContext
        
        let item = City(context: viewContext)
        item.name = "长沙市"
        item.adcode = "430104"
        item.id = UUID()
        item.timestamp = Date()
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
        return result
    }()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "ThreeDays")
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}
