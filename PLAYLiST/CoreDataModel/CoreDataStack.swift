//
//  CoreDataContext.swift
//  PLAYLiST
//
//  Created by Nyilas Zsombor on 2021. 10. 24..
//

import Foundation
import CoreData

// helper class, that handles the CoreData context creation
struct CoreDataStack {
    
    static var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print(error)
            }
        }
        return container
    }()

    static func saveContext() {
        let context = CoreDataStack.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    static func createInitialSong() -> Song {
        let song = Song(context: context)
        song.uri = ""
        song.artist = ""
        song.title = ""
        song.streamingService = ""
        saveContext()
        return song
    }
}

