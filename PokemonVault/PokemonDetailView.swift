//
//  PokemonDetailView.swift
//  PokemonVault
//
//  Created by Khush  on 18/11/26.
//

import Foundation
import SwiftUI
import CoreData

struct PokemonDetailView: View {
    
    let pokemon: Pokemon
    
    var body: some View {
        
        ScrollView {
            VStack(spacing: 20) {
                
                AsyncImage(url: URL(string: pokemon.img ?? "")) { image in image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 150, height: 150)
                
                Text(pokemon.name ?? "Unknown")
                    .font(.largeTitle)
                
                Text("ID: \(pokemon.id)")
                Text("Ability: \(pokemon.ability ?? "")")
                Text("Attack Type: \(pokemon.attackType ?? "")")
                Text("Color: \(pokemon.color ?? "")")
                Text("Generation: \(pokemon.gen)")
                Text("Nature: \(pokemon.nature ?? "")")
                Text("Type: \(pokemon.type ?? "")")
            }
            .padding()
        }
        .navigationTitle("Details")
        
    } //body
    
} //struct



#Preview {
    let context = PersistenceController.preview.container.viewContext
    let sample = Pokemon(context: context)
    sample.name = "charizard"
    sample.id = 6
    sample.ability = "Blaze"
    sample.attackType = "Fire"
    sample.color = "Red"
    sample.nature = "Adamant"
    sample.type = "Fire"
    sample.gen = 1
    return PokemonDetailView(pokemon: sample )
}
