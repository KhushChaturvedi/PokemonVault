//
//  SavedPokemonView.swift
//  PokemonVault
//
//  Created by Khush  on 16/11/26.
//

import SwiftUI
import CoreData

struct SavedPokemonView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor (keyPath: \Pokemon.name, ascending: true)]
    )
    
    private var pokemons: FetchedResults<Pokemon>
    
    var body: some View {
        List {
            ForEach(pokemons) { pokemon in
                Text(pokemon.name ?? "Unknown")
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            deletePokemon(pokemon)
                        } label: {
                            Label("",systemImage: "trash")
                        }
                    }
                
            }
        }
        .navigationTitle("Saved Pokemon")
    }
    
    private func deletePokemon(_ pokemon: Pokemon) {
        viewContext.delete(pokemon)
        do {
            try viewContext.save()
        } catch {
            print("could not delete")
        }
    }
}


#Preview {
    NavigationStack{
        SavedPokemonView()
    }
}
