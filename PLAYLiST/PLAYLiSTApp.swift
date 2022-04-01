//
//  PLAYLiSTApp.swift
//  PLAYLiST
//
//  Created by Nyilas Zsombor on 2021. 09. 20..
//

import SwiftUI
import CoreData

@main
struct PLAYLiSTApp: App {
    // accessing the lifecycle of the application, used to save CoreData context when needed
    @Environment(\.scenePhase) private var scenePhase
    // creating the single SpotifyController object, that will be used throughout the application
    @StateObject var spotifyController = SpotifyController()
    
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                // injecting the SpotifyController and the CoreData context into the environment,
                // so child views of the MainTabView can access them as well
                .environmentObject(spotifyController)
                .environment(\.managedObjectContext, CoreDataStack.persistentContainer.viewContext)
        }
        // handling the phase changes, so the CoreData context gets saved, when the app goes into the background
        .onChange(of: scenePhase) { phase in
                    switch phase {
                    case .active:
                        print("active")
                    case .inactive:
                        print("inactive")
                    case .background:
                        print("background")
                        CoreDataStack.saveContext()
                    @unknown default:
                        fatalError()
                    }
                }
    }
    
}

