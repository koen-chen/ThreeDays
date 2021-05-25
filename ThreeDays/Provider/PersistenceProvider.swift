//
//  PersistenceProvider.swift
//  ThreeDays
//
//  Created by koen.chen on 2021/5/21.
//

import CoreData

struct PersistenceProvider {
    static let shared = PersistenceProvider()
    
    let container: NSPersistentContainer
    
    var managedObjectContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "ThreeDays")
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    func saveContext () {
        let context = Self.shared.container.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func clearEntity (_ entity: String = "Place") {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try Self.shared.container.viewContext.execute(deleteRequest)
        } catch let error as NSError {
            print("Failed Clear. \(error), \(error.userInfo)")
        }
    }

    func checkEntityHasData (_ predicate: NSPredicate, entity: String = "Place") -> Bool {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entity)
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = predicate

        do {
            let count = try Self.shared.container.viewContext.count(for: fetchRequest)

            if count > 0 {
                return true
            } else {
                return false
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return false
        }
    }

    func fetchDataForEntity (_ predicate: NSPredicate, entity: String = "Place") -> [Place] {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entity)
        fetchRequest.predicate = predicate

        var result = [Place]()

        do {
            let records = try Self.shared.container.viewContext.fetch(fetchRequest)

            if let records = records as? [Place] {
                result = records
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }

        return result
    }
}

//import SwiftUI
//import CoreData
//
//class PersistenceProvider {
//    static let shared = PersistenceProvider()
//
//    var managedObjectContext: NSManagedObjectContext {
//        return persistentContainer.viewContext
//    }
//
//    lazy var persistentContainer: NSPersistentContainer = {
//        let container = NSPersistentContainer(name: "ThreeDays")
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//        return container
//    }()
//
//    func saveContext () {
//        let context = persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }
//
//    func clearEntity (_ entity: String = "Place") {
//        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entity)
//        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//
//        do {
//            try persistentContainer.viewContext.execute(deleteRequest)
//        } catch let error as NSError {
//            print("Failed Clear. \(error), \(error.userInfo)")
//        }
//    }
//
//    func checkEntityHasData (_ predicate: NSPredicate, entity: String = "Place") -> Bool {
//        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entity)
//        fetchRequest.fetchLimit = 1
//        fetchRequest.predicate = predicate
//
//        do {
//            let count = try persistentContainer.viewContext.count(for: fetchRequest)
//
//            if count > 0 {
//                return true
//            } else {
//                return false
//            }
//        } catch let error as NSError {
//            print("Could not fetch. \(error), \(error.userInfo)")
//            return false
//        }
//    }
//
//    func fetchDataForEntity (_ predicate: NSPredicate, entity: String = "Place") -> [Place] {
//        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entity)
//        fetchRequest.predicate = predicate
//
//        var result = [Place]()
//
//        do {
//            let records = try persistentContainer.viewContext.fetch(fetchRequest)
//
//            if let records = records as? [Place] {
//                result = records
//            }
//        } catch let error as NSError {
//            print("Could not fetch. \(error), \(error.userInfo)")
//        }
//
//        return result
//    }
//}
