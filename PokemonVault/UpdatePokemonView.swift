//
//  UpdatePokemonView.swift
//  PokemonVault
//
//  Created by Khush  on 18/11/26.
//

import SwiftUI
import CoreData

struct UpdatePokemonView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    let pokemon: Pokemon
    
    @State private var idText = ""
    @State private var name = ""
    @State private var ability = ""
    @State private var attackType = ""
    @State private var color = ""
    @State private var img = ""
    @State private var genText = ""
    @State private var levelText = ""
    @State private var nature = ""
    @State private var typeText = ""
    @State private var errorMessage = ""
    
    var body: some View {
        Form {
            Section("Update Details") {
                TextField("ID", text: $idText)
                    .keyboardType(.numberPad)
                TextField("Name", text: $name)
                TextField("Ability", text: $ability)
                TextField("Attack Type", text: $attackType)
                TextField("Color", text: $color)
                TextField("Image URL", text: $img)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                TextField("Gen (number)", text: $genText)
                    .keyboardType(.numberPad)
                TextField("Level (number)", text: $levelText)
                    .keyboardType(.numberPad)
                TextField("Nature", text: $nature)
                TextField("Type", text: $typeText)
            }
            
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundStyle(.red)
            }
            
            Button("Update Pokemon") {
                updatePokemon()
            }
        }
        .navigationTitle("Update pokemon")
        .onAppear {
            idText = String(pokemon.id)
                        name = pokemon.name ?? ""
                        ability = pokemon.ability ?? ""
                        attackType = pokemon.attackType ?? ""
                        color = pokemon.color ?? ""
                        img = pokemon.img ?? ""
                        genText = String(pokemon.gen)
                        levelText = String(pokemon.level)
                        nature = pokemon.nature ?? ""
                        typeText = pokemon.type ?? ""
        }
    } // body
    
    private func updatePokemon() {
        guard let idValue = Int64(idText),
              let genValue = Int64(genText),
              let levelValue = Int64(levelText) else {
            errorMessage = "ID, Gen and Level must be numbers"
            return
        }
        
        if name.isEmpty {
            errorMessage = "Please enter name"
            return
        }
        
        pokemon.id = idValue
        pokemon.name = name
        pokemon.ability = ability
        pokemon.attackType = attackType
        pokemon.color = color
        pokemon.img = img
        pokemon.gen = genValue
        pokemon.level = levelValue
        pokemon.nature = nature
        pokemon.type = typeText
        
        
        do {
            try viewContext.save()
            dismiss()
        } catch {
            errorMessage = "could not update \(error.localizedDescription)"
        }
        
        
    }
} // struct


#Preview {
    let context = PersistenceController.preview.container.viewContext
    let sample = Pokemon(context: context)
    sample.name = "charizard"
    sample.id = 6
    return NavigationStack {
        UpdatePokemonView(pokemon: sample)
    }
}
