import SwiftUI

struct PersonneDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var personne: Personne

    @State private var nom: String = ""
    @State private var age: String = ""

    var body: some View {
        Form {
            Section(header: Text("Informations")) {
                TextField("Nom", text: $nom)
                TextField("Âge", text: $age)
                    .keyboardType(.numberPad)
            }
        }
        .navigationTitle("Détails")
        .onAppear {
            nom = personne.nom ?? ""
            age = String(personne.age)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Enregistrer") {
                    saveChanges()
                }
                .disabled(nom.isEmpty || age.isEmpty)
            }
        }
    }

    private func saveChanges() {
        withAnimation {
            personne.nom = nom
            if let ageInt = Int16(age) {
                personne.age = ageInt
            }

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
