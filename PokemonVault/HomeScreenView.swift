//
//  HomeScreenView.swift
//  PokemonVault
//
//  Created by Khush  on 16/11/26.
//

import SwiftUI

struct HomeScreenView: View {
    
    var body: some View {
        
        NavigationStack {
            VStack(spacing: 20) {
                
                NavigationLink("Add new Pokemon") {
                    AddPokemonView()
                }
                
                NavigationLink("View all saved Pokemon") {
                    SavedPokemonView()
                }
            }
            .buttonStyle(.borderedProminent)
            .navigationTitle("Pokemon")
        }
    }
}


#Preview {
    HomeScreenView()
}
