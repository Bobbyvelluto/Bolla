import SwiftUI

struct RoleSelectionView: View {
    @State private var isAdminViewActive = false // Stato per navigazione alla schermata Admin
    @State private var isPressed = false // Stato per l'effetto pressione

    var body: some View {
        VStack {
            // Sfondo con il padding modificato
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white.opacity(0.3)) // Sfondo semi-trasparente
                .frame(width: 250, height: 150) // Nuovo padding (altezza e larghezza modificati)
                .overlay(
                    HStack(spacing: 20) {
                        // Icona "Divieto d'accesso"
                        Image(systemName: "hand.raised.fill")
                            .foregroundColor(.red)
                            .font(.system(size: 35))
                            .padding()

                        // Scritta "Admin"
                        Text("Admin")
                            .font(.title2.bold())
                            .foregroundColor(.black)
                            .padding()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading) // Allineamento a sinistra
                )
                .padding(20)
                .shadow(radius: 10)
        }
        .navigationDestination(isPresented: $isAdminViewActive) {
            AdminCalendarView() // Pagina Admin
        }
    }
}

struct RoleSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        RoleSelectionView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
