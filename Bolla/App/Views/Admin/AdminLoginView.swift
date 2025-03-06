import SwiftUI

struct AdminLoginView: View {
    @State private var adminCode = "" // Codice inserito dall'utente
    @State private var isAuthenticated = false // Stato di autenticazione
    @State private var isError = false // Flag per errore nel codice

    let correctCode = "998899" // Codice corretto per accedere come admin

    var body: some View {
        VStack {
            Text("Accedi come Admin")
                .font(.title2)
                .bold()
                .padding()

            // Campo di inserimento del codice
            SecureField("Inserisci codice admin", text: $adminCode)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 250)
                .padding(.bottom, 20)

            // Messaggio di errore se il codice è sbagliato
            if isError {
                Text("Codice errato! Riprova.")
                    .foregroundColor(.red)
                    .padding()
            }

            // Pulsante di accesso con icona di mano alzata
            HStack(spacing: 10) {
                Button(action: {
                    authenticateAdmin()
                }) {
                    Text("Accedi")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }

                // Icona di mano alzata con padding bianco dinamico
                Image(systemName: "hand.raised.fill")
                    .foregroundColor(.red)
                    .font(.title)
                    .padding(10)
                    .background(Color.white.opacity(0.8))
                    .clipShape(Circle())
            }
            .padding()

            Spacer()
        }
        .padding()
        .navigationDestination(isPresented: $isAuthenticated) {
            AdminCalendarView() // Navigazione al calendario dell'amministratore dopo autenticazione
        }
    }

    // Funzione per verificare il codice dell'admin
    func authenticateAdmin() {
        if adminCode == correctCode {
            isAuthenticated = true
            isError = false
        } else {
            isError = true
        }
    }
}

struct AdminLoginView_Previews: PreviewProvider {
    static var previews: some View {
        AdminLoginView()
    }
}
