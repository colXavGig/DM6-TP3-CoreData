import SwiftUI

struct AddPersonneView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode

    @State private var nom: String = ""
    @State private var age: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Informations")) {
                    TextField("Nom", text: $nom)
                    TextField("Âge", text: $age)
                        .keyboardType(.numberPad)
                }
            }
            .navigationTitle("Ajouter une personne")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Annuler") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Enregistrer") {
                        addPersonne()
                    }
                    .disabled(nom.isEmpty || age.isEmpty)
                }
            }
        }
    }

    private func addPersonne() {
        withAnimation {
            let newPersonne = Personne(context: viewContext)
            newPersonne.nom = nom
            if let ageInt = Int16(age) {
                newPersonne.age = ageInt
            }

            do {
                try viewContext.save()
                presentationMode.wrappedValue.dismiss()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
