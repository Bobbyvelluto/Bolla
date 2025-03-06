import SwiftUI

struct MainView: View {
    @State private var isLoginViewActive = false // Stato per navigazione alla login
    @State private var isSwipeActive = false // Stato per il gesto di swipe verso admin
    @State private var isSwipeBackActive = false // Stato per il gesto di swipe verso indietro

    var body: some View {
        NavigationStack {
            ZStack {
                // Immagine di sfondo
                Image("main")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()

                VStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white.opacity(0.3)) // Sfondo semi-trasparente
                        .frame(width: 180, height: 170)
                        .overlay(
                            VStack(spacing: 10) {
                                // Pulsante con effetto per accedere alla LoginView
                                Button(action: {
                                    isLoginViewActive = true
                                }) {
                                    Image("logosign")
                                        .resizable()
                                        .frame(width: 70, height: 70)
                                        .padding()
                                        .background(
                                            RoundedRectangle(cornerRadius: 15)
                                                .fill(Color.white.opacity(0.2))
                                                .shadow(color: .black.opacity(0.3), radius: 5, x: 2, y: 2)
                                        )
                                }
                                .buttonStyle(PlainButtonStyle())

                                Text("JOIN THE CLUB")
                                    .foregroundColor(.white)
                                    .font(.title3.bold())
                                    .shadow(color: .black, radius: 9, x: 1, y: 1)
                            }
                        )
                }
                .offset(y: 300)
            }
            // Gestione dei gesti di swipe
            .gesture(
                DragGesture()
                    .onEnded { value in
                        // Gesto verso destra per aprire la pagina Admin
                        if value.translation.width > 100 {
                            isSwipeActive = true
                        }
                        // Gesto verso sinistra per tornare alla MainView
                        else if value.translation.width < -100 {
                            isSwipeBackActive = true
                        }
                    }
            )
            // Navigazione alla LoginView
            .navigationDestination(isPresented: $isLoginViewActive) {
                LoginView() // Navigazione alla LoginView
            }
            // Navigazione alla pagina AdminLoginView
            .navigationDestination(isPresented: $isSwipeActive) {
                AdminLoginView() // Navigazione alla AdminLoginView dopo swipe verso destra
            }
            // Navigazione indietro alla MainView
            .navigationDestination(isPresented: $isSwipeBackActive) {
                MainView() // Navigazione indietro alla MainView dopo swipe verso sinistra
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
