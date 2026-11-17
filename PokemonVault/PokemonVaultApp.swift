//
//  PokemonVaultApp.swift
//  PokemonVault
//
//  Created by Khush  on 16/11/26.
//

import SwiftUI
import CoreData

@main
struct PokemonVaultApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeScreenView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
