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
    
    @State private var pokemonToUpdate: Pokemon?
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor (keyPath: \Pokemon.name, ascending: true)]
    )
    
    private var pokemons: FetchedResults<Pokemon>
    
    var body: some View {
        List {
            ForEach(pokemons) { pokemon in
                NavigationLink {
                    PokemonDetailView(pokemon: pokemon)
                } label: {
                    Text(pokemon.name ?? "Unknown") }
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            deletePokemon(pokemon)
                        } label: {
                            Label("",systemImage: "trash")
                        }
                    }
                    .swipeActions(edge: .leading, allowsFullSwipe: false) {
                        Button {
                            pokemonToUpdate = pokemon
                        } label: {
                            Label("", systemImage: "pencil")
                        }
                        .tint(.blue)
                    }
                
            }
        }
        .navigationTitle("Saved Pokemon")
        .navigationDestination(item: $pokemonToUpdate) {
            pokemon in UpdatePokemonView(pokemon: pokemon)
        }
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
