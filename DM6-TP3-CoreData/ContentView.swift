import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Personne.nom, ascending: true)],
        animation: .default)
    private var personnes: FetchedResults<Personne>
    @State private var showingAddPersonne = false

    var body: some View {
        NavigationView {
            List {
                ForEach(personnes) { personne in
                    NavigationLink(destination: PersonneDetailView(personne: personne)) {
                        VStack(alignment: .leading) {
                            Text(personne.nom ?? "Sans nom")
                                .font(.headline)
                            Text("Âge : \(personne.age)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .onDelete(perform: deletePersonnes)
            }
            .navigationTitle("Personnes")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddPersonne = true }) {
                        Label("Ajouter", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddPersonne) {
                AddPersonneView().environment(\.managedObjectContext, viewContext)
            }
        }
    }

    private func deletePersonnes(offsets: IndexSet) {
        withAnimation {
            offsets.map { personnes[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
