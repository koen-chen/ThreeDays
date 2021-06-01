//
//  PersistenceService.swift
//  ThreeDays
//
//  Created by koen.chen on 2021/5/21.
//

import CoreData

struct PersistenceService {
    static let shared = PersistenceService()
    
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
            context.perform {
                do {
                    try context.save()
                } catch {
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }
    }
    
    func clearEntity (_ entity: String = "Place") {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try Self.shared.container.viewContext.execute(deleteRequest)
        } catch let error as NSError {
            print("清理数据失败. \(error), \(error.userInfo)")
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
            print("不能获取数据. \(error), \(error.userInfo)")
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
            print("不能获取数据. \(error), \(error.userInfo)")
        }

        return result
    }
}
