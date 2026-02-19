//
//  CoreDataStack.swift
//  Todo_Hackathon_Assingment
//
//  Created by Vishal Pawar on 19/02/26.
//

import Foundation
import CoreData


final class CoreDataStack{
    
    static let shared = CoreDataStack()
    let container : NSPersistentContainer
    
    private init(){
        container = NSPersistentContainer(name: "TasksDataModel")
        container.loadPersistentStores{_, error in
            
            if let error = error{
                fatalError("failed store \(error)")
            }
            
            
        }
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.automaticallyMergesChangesFromParent = true
        
    }
    
    var context: NSManagedObjectContext {
            container.viewContext
        }

        func save() {
            if context.hasChanges {
                try? context.save()
            }
        }
}
