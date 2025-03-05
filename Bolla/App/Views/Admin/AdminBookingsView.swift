import SwiftUI

struct AdminBookingsView: View {
    var body: some View {
        VStack {
            Text("Gestione Prenotazioni")
                .font(.title)
                .padding()

            // Esempio di lista prenotazioni
            List {
                Text("Prenotazione 1")
                Text("Prenotazione 2")
                Text("Prenotazione 3")
            }
        }
        .navigationTitle("Prenotazioni")
    }
}

struct AdminBookingsView_Previews: PreviewProvider {
    static var previews: some View {
        AdminBookingsView()
    }
}
