//
//  APITestAppApp.swift
//  APITestApp
//
//  Created by Prince Embola on 02/10/2021.
//

import SwiftUI

@main
struct APITestAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            NavigationView{
                APIInfoView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
           
        }
    }
}
