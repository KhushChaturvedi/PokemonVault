# PokemonVault

PokemonVault is an iOS app for cataloguing a personal Pokemon collection.
Each entry stores ten attributes and is saved on the device with Core Data.
Entries can be viewed, edited and deleted using native iOS gestures, and
Pokemon artwork is loaded over the network on the detail screen.

## Features

- Home screen with two entry points: add a Pokemon, or view saved Pokemon
- Add form with 10 attributes: id, name, ability, attack type, colour,
  image URL, generation, level, nature and type
- Input validation: numeric fields are parsed safely, empty names are
  rejected, and errors appear inline in red
- Saved list sorted A to Z, backed by a live Core Data fetch
- Tap a row to open a detail screen with all fields and a remote image
- Swipe from the trailing edge to delete an entry
- Swipe from the leading edge to open a pre-filled update form

## Tech stack

| Area | Technology |
|---|---|
| Language | Swift |
| UI | SwiftUI |
| Persistence | Core Data |
| Networking | AsyncImage |
| IDE | Xcode |
| Platform | iOS |

## Skills and concepts applied

### Data layer (Core Data)
- Data model design: entity and typed attributes (Integer 64, String)
- Generated NSManagedObject subclasses via Codegen (Class Definition)
- NSPersistentContainer setup and store loading
- In-memory store for SwiftUI previews
- Shared PersistenceController (singleton pattern)
- Create, read, update and delete with NSManagedObjectContext
- Persisting changes with try viewContext.save()

### SwiftUI
- Layout with VStack, ScrollView, Form, Section, List and ForEach
- NavigationStack, NavigationLink and navigationDestination(item:)
- swipeActions on leading and trailing edges, with destructive roles
- Keyboard configuration (numberPad, autocapitalisation, autocorrection)
- Conditional UI for inline error messages
- AsyncImage with a loading placeholder
- Previews backed by an in-memory store

### State and data flow
- @State for form state and the currently selected item
- Two-way bindings with $ on TextField
- @Environment(\.managedObjectContext) to inject the database context
- @Environment(\.dismiss) to close a screen after saving
- @FetchRequest with NSSortDescriptor for a self-updating list
- Passing a managed object between screens
- Pre-filling a form with onAppear

### Swift language
- Optionals and nil-coalescing (??) for Core Data's optional strings
- guard let with multiple conditions and early exit
- do / try / catch error handling
- String to Int64 conversion for typed storage
- Access control with private and single-purpose functions

### Engineering practice
- Validating input before persistence
- Separating screens into focused views
- Git and GitHub for version control

## Architecture

```
User input (Form)
      |
      v
Validation (guard let, isEmpty)
      |
      v
NSManagedObjectContext --save()--> Core Data store
      ^                                  |
      |                                  v
@FetchRequest <------------------ List updates automatically
```

PokemonVaultApp injects one shared context into the environment, so every
screen reads and writes the same store.

## Project structure

```
PokemonVault/
├── PokemonVaultApp.swift       App entry, injects the Core Data context
├── Persistence.swift           Core Data stack
├── PokemonVault.xcdatamodeld   Pokemon entity (10 attributes)
├── HomeScreenView.swift        Entry screen
├── AddPokemonView.swift        Add form, validation, save
├── SavedPokemonView.swift      List, fetch, swipe delete and update
├── PokemonDetailView.swift     Detail screen with remote image
└── UpdatePokemonView.swift     Pre-filled edit form
```

## Data model

| Attribute | Type |
|---|---|
| id | Integer 64 |
| name | String |
| ability | String |
| attackType | String |
| color | String |
| img | String (image URL) |
| gen | Integer 64 |
| level | Integer 64 |
| nature | String |
| type | String |

## Run it

1. Clone the repository
2. Open `PokemonVault.xcodeproj` in Xcode
3. Choose an iPhone simulator and press Cmd + R

The image URL field expects a direct link to a picture, for example:

```
https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png
```
