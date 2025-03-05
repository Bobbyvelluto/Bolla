import SwiftUI

struct AdminLoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isAuthenticated: Bool = false // Stato per la navigazione

    var body: some View {
        NavigationStack {
            ZStack {
                // Immagine di sfondo (puoi cambiarla con un'immagine adatta)
                Color.gray.opacity(0.2)
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: 20) {
                    // Campo per l'username
                    TextField("Username", text: $username)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                        .padding(.horizontal, 20)

                    // Campo per la password
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                        .padding(.horizontal, 20)

                    // Pulsante di login
                    Button(action: {
                        // Verifica le credenziali
                        if username == "admin" && password == "password" {
                            isAuthenticated = true
                        } else {
                            print("Credenziali errate")
                        }
                    }) {
                        Text("Login")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal, 20)
                }
                .navigationDestination(isPresented: $isAuthenticated) {
                    
                }
            }
            .navigationTitle("Admin Login")
        }
    }
}

struct AdminLoginView_Previews: PreviewProvider {
    static var previews: some View {
        AdminLoginView()
    }
}
