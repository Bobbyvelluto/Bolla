import SwiftUI

struct LoginView: View {
    @State private var telefono: String = ""
    @State private var nome: String = ""
    @State private var cognome: String = ""
    @State private var isRegistratiButtonEnabled: Bool = false
    @State private var isRegistered: Bool = false

    var body: some View {
        NavigationView {
            ZStack {
                // Immagine di sfondo "sfondo2"
                Image("segreteria")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()

                VStack {
                    // Moduli di input
                    TextField("Telefono", text: $telefono)
                        .padding()
                        .frame(width: 200) // Riduci la larghezza dei moduli
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 2) // Aggiungi contorno nero
                        )
                        .shadow(radius: 3) // Aggiungi ombra leggera

                    TextField("Nome", text: $nome)
                        .padding()
                        .frame(width: 200) // Riduci la larghezza dei moduli
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 2) // Aggiungi contorno nero
                        )
                        .shadow(radius: 3) // Aggiungi ombra leggera

                    TextField("Cognome", text: $cognome)
                        .padding()
                        .frame(width: 200) // Riduci la larghezza dei moduli
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 2) // Aggiungi contorno nero
                        )
                        .shadow(radius: 3) // Aggiungi ombra leggera

                    // Pulsante "Registrati"
                    NavigationLink(destination: HomeView(), isActive: $isRegistered) {
                        Text("Registrati")
                            .foregroundColor(.white)
                            .padding()
                            .background(isRegistratiButtonEnabled ? Color.green : Color.yellow) // Cambia il colore del pulsante
                            .cornerRadius(10)
                    }
                    .disabled(!isRegistratiButtonEnabled)
                    .simultaneousGesture(TapGesture().onEnded {
                        isRegistered = true
                    })
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
        }
    }

    private func updateRegistratiButtonState() {
        isRegistratiButtonEnabled = !telefono.isEmpty && !nome.isEmpty && !cognome.isEmpty
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
