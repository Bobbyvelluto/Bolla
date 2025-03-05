import SwiftUI

struct AdminSettingsView: View {
    var body: some View {
        VStack {
            Text("Impostazioni")
                .font(.title)
                .padding()

            // Esempio di opzioni
            List {
                Text("Modifica Password")
                Text("Notifiche")
                Text("Logout")
            }
        }
        .navigationTitle("Impostazioni")
    }
}

struct AdminSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        AdminSettingsView()
    }
}
