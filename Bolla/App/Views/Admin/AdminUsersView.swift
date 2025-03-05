import SwiftUI

struct AdminUsersView: View {
    var body: some View {
        VStack {
            Text("Gestione Utenti")
                .font(.title)
                .padding()

            // Esempio di lista utenti
            List {
                Text("Utente 1")
                Text("Utente 2")
                Text("Utente 3")
            }
        }
        .navigationTitle("Utenti")
    }
}

struct AdminUsersView_Previews: PreviewProvider {
    static var previews: some View {
        AdminUsersView()
    }
}
