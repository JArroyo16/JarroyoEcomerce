//
//  AppDelegate.swift
//  JarroyoEcomerceVenta
//
//  Created by MacBookMBP1 on 25/05/23.
//

import UIKit
import CoreData
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    lazy var persistentContainer: NSPersistentContainer = {
           let container = NSPersistentContainer(name: "JarroyoEcomerce")
           container.loadPersistentStores { description, error in
               if let error = error {
                   fatalError("Unable to load persistent stores: \(error)")
               }
               print("Conexion exitosa core data")
           }
        print(container.persistentStoreDescriptions.first?.url)
           return container
       }()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

