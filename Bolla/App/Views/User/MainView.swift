import SwiftUI

struct MainView: View {
    @State private var isLoginViewActive = false // Stato per la navigazione

    var body: some View {
        NavigationStack {
            ZStack {
                // Immagine di sfondo (assicurati di avere "wbbs1" nell'Assets)
                Image("wbbs1")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()

                // Cornice con icona e testo
                VStack {
                    RoundedRectangle(cornerRadius: 20) // Puoi cambiare la forma e l'aspetto
                        .fill(Color.white.opacity(0.3)) // Colore e trasparenza dello sfondo
                        .frame(width: 180, height: 170) // Diminuisci la dimensione dello sfondo
                        .overlay(
                            VStack(spacing: 10) { // Riduce lo spazio tra icona e testo
                                // Icona "sign" (assicurati di avere "sign" nell'Assets)
                                Button(action: {
                                    isLoginViewActive = true // Attiva la navigazione
                                }) {
                                    Image("sign")
                                        .resizable()
                                        .frame(width: 70, height: 70) // Diminuisci le dimensioni dell'icona
                                        .padding(.bottom, 0) // Rimuovi il padding predefinito
                                }

                                // Testo "JOIN THE CLUB"
                                Text("JOIN THE CLUB")
                                    .foregroundColor(.white)
                                    .font(.title3.bold()) // Diminuisci la dimensione del testo
                                    .shadow(color: .black, radius: 9, x: 1, y: 1) // Aggiungi l'ombra
                                    .padding(.top, 0) // Rimuovi il padding predefinito
                            }
                        )
                }
                .offset(y: 300) // Sposta il tutto verso il basso
            }
            .navigationDestination(isPresented: $isLoginViewActive) {
                LoginView() // Naviga a LoginView quando isLoginViewActive è true
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
