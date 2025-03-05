import SwiftUI

struct LoginView: View {
    @State private var telefono: String = ""
    @State private var nome: String = ""
    @State private var cognome: String = ""
    @State private var isRegistratiButtonEnabled: Bool = false
    @State private var isHomeViewActive: Bool = false // Stato per la navigazione

    var body: some View {
        NavigationStack {
            ZStack {
                // Immagine di sfondo (assicurati di avere "segretaria" nell'Assets)
                Image("segretaria")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()

                VStack {
                    // Moduli di input
                    TextField("Telefono", text: $telefono)
                        .padding()
                        .frame(width: 200)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 2)
                        )
                        .shadow(radius: 3)

                    TextField("Nome", text: $nome)
                        .padding()
                        .frame(width: 200)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 2)
                        )
                        .shadow(radius: 3)

                    TextField("Cognome", text: $cognome)
                        .padding()
                        .frame(width: 200)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 2)
                        )
                        .shadow(radius: 3)

                    // Pulsante "Registrati"
                    Button(action: {
                        isHomeViewActive = true // Attiva la navigazione
                    }) {
                        Text("Registrati")
                            .foregroundColor(.white)
                            .padding()
                            .background(isRegistratiButtonEnabled ? Color.green : Color.yellow)
                            .cornerRadius(10)
                    }
                    .disabled(!isRegistratiButtonEnabled)
                }
                .padding()
                .offset(y: 270) // Sposta i moduli più in basso
                .onChange(of: telefono) { _ in
                    updateRegistratiButtonState()
                }
                .onChange(of: nome) { _ in
                    updateRegistratiButtonState()
                }
                .onChange(of: cognome) { _ in
                    updateRegistratiButtonState()
                }
            }
            .navigationDestination(isPresented: $isHomeViewActive) {
                HomeView() // Naviga a HomeView quando isHomeViewActive è true
            }
        }
    }

    // Funzione per abilitare/disabilitare il pulsante "Registrati"
    private func updateRegistratiButtonState() {
        isRegistratiButtonEnabled = !telefono.isEmpty && !nome.isEmpty && !cognome.isEmpty
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
