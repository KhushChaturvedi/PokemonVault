//
//  AddPokemonView.swift
//  PokemonVault
//
//  Created by Khush  on 16/11/26.
//

import SwiftUI
import CoreData

struct AddPokemonView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
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
            Section("Pokemon Details") {
                
                TextField("ID", text: $idText)
                    .keyboardType(.numberPad)
                
                TextField("Name", text: $name)
                
                TextField("Ability", text: $ability)
                
                TextField("Attack Type", text: $attackType)
                
                TextField("Color", text: $color)
                
                TextField("img", text: $img)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                 
                TextField("Generation", text: $genText)
                    .keyboardType(.numberPad)
                
                TextField("Level", text: $levelText)
                    .keyboardType(.numberPad)
                
                TextField("Nature", text: $nature)
                
                TextField("Type", text: $typeText)
            }
            
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundStyle(.red)
            }
            
            Button("Save Pokemon") {
                savePokemon()
            }
        }
        
        .navigationTitle("Add Pokemon")
        
    } // body
    
    private func savePokemon() {
        guard let idValue = Int64(idText),
              let genValue = Int64(genText),
              let levelValue = Int64(levelText) else {
            errorMessage = "ID, Generation and Level must be numbers"
            return
        }
            
        if name.isEmpty {
            errorMessage = "Please enter the name"
            return
        }
        
        let pokemon = Pokemon(context: viewContext)
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
            errorMessage = "could not save: \(error.localizedDescription)"
        }
    }
    
}


#Preview {
    NavigationStack{
        AddPokemonView()
    }
}
