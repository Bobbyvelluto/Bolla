import SwiftUI
import UIKit

struct HomeView: View {
    @State private var isCalendarViewPresented: Bool = false

    var body: some View {
        NavigationView {
            ZStack {
                // Immagine di sfondo "Sfondofico"
                Image("Sfondofico")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()

                // Testo "BENVENUTO NELLA WILSON BASETTA BOXING SCHOOL" su tre righe con contorno nero
                VStack {
                    Text("BENVENUTO NELLA")
                        .font(.custom("Impact", size: 30).italic())
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 5, x: 0, y: 5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 0)
                                .stroke(.black, lineWidth: 2) // Aggiungi un contorno nero di 2 punti
                        )
                    Text("WILSON BASETTA")
                        .font(.custom("Impact", size: 30).italic())
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 5, x: 0, y: 5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 0)
                                .stroke(.black, lineWidth: 2) // Aggiungi un contorno nero di 2 punti
                        )
                    Text("BOXING SCHOOL")
                        .font(.custom("Impact", size: 30).italic())
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 5, x: 0, y: 5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 0)
                                .stroke(.black, lineWidth: 2) // Aggiungi un contorno nero di 2 punti
                        )
                }
                .padding(.top, 50) // Riduci lo spazio sopra il testo per spostarlo più in alto

                // Fila di icone in basso
                VStack {
                    Spacer() // Spinge le icone verso il basso

                    HStack {
                        // Icona "contact"
                        Button(action: {
                            // Azione per "contact"
                            openWhatsApp(phoneNumber: "3355405933")
                            print("Contact tapped!")
                        }) {
                            Image("contact")
                                .resizable()
                                .frame(width: 60, height: 60) // Aumenta le dimensioni dell'icona
                                .overlay(
                                    Circle()
                                        .stroke(Color.green, lineWidth: 2) // Aggiungi un cerchio verde
                                        .frame(width: 70, height: 70) // Assicurati che il cerchio contenga l'icona
                                )
                        }

                        // Icona "the book"
                        Button(action: {
                            // Azione per "the book"
                            openURL(urlString: "https://www.amazon.it/Boxe-Gleasons-Gym-Ediz-illustrata/dp/8827226850")
                            print("The book tapped!")
                        }) {
                            Image("libro")
                                .resizable()
                                .frame(width: 60, height: 60) // Aumenta le dimensioni dell'icona
                                .overlay(
                                    Circle()
                                        .stroke(Color.green, lineWidth: 2) // Aggiungi un cerchio verde
                                        .frame(width: 70, height: 70) // Assicurati che il cerchio contenga l'icona
                                )
                        }

                        // Icona "prenota"
                        Button(action: {
                            // Azione per "prenota"
                            isCalendarViewPresented = true
                            print("Prenota tapped!")
                        }) {
                            Image("prenota")
                                .resizable()
                                .frame(width: 60, height: 60) // Aumenta le dimensioni dell'icona
                                .overlay(
                                    Circle()
                                        .stroke(Color.green, lineWidth: 2) // Aggiungi un cerchio verde
                                        .frame(width: 70, height: 70) // Assicurati che il cerchio contenga l'icona
                                )
                        }

                        // Icona "shop"
                        Button(action: {
                            // Azione per "shop"
                            openURL(urlString: "https://wilsonbasetta.wixsite.com/wilsonbasetta/about-1")
                            print("Shop tapped!")
                        }) {
                            Image("shop")
                                .resizable()
                                .frame(width: 40, height: 40) // Riduci le dimensioni dell'icona "shop"
                                .overlay(
                                    Circle()
                                        .stroke(Color.green, lineWidth: 2) // Aggiungi un cerchio verde
                                        .frame(width: 60, height:60) // Assicurati che il cerchio contenga l'icona
                                )
                        }

                        // Icona "start"
                        NavigationLink(destination: StartView()) {
                            Image("start")
                                .resizable()
                                .frame(width: 60, height: 60) // Aumenta le dimensioni dell'icona
                                .overlay(
                                    Circle()
                                        .stroke(Color.green, lineWidth: 2) // Aggiungi un cerchio verde
                                        .frame(width: 70, height: 70) // Assicurati che il cerchio contenga l'icona
                                )
                        }
                    }
                    .padding(.bottom, 20) // Aggiunge un po' di spazio dal bordo inferiore
                    .background(Color.clear) // Rende lo sfondo dell'HStack trasparente
                }
            }
            .sheet(isPresented: $isCalendarViewPresented) {
                CalendarView()
            }
        }
    }

    // Funzione per aprire WhatsApp
    func openWhatsApp(phoneNumber: String) {
        let whatsappURL = URL(string: "https://api.whatsapp.com/send?phone=\(phoneNumber)")

        if UIApplication.shared.canOpenURL(whatsappURL!) {
            UIApplication.shared.open(whatsappURL!, options: [:], completionHandler: nil)
        } else {
            // WhatsApp non è installato
            print("WhatsApp non è installato!")
            // Puoi mostrare un alert all'utente
            let alert = UIAlertController(title: "WhatsApp", message: "WhatsApp non è installato.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

            // Trova la view controller corrente e presenta l'alert
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let rootViewController = windowScene.windows.first?.rootViewController {
                rootViewController.present(alert, animated: true, completion: nil)
            }
        }
    }

    // Funzione per aprire un URL
    func openURL(urlString: String) {
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            // URL non valido
            print("URL non valido!")
            // Puoi mostrare un alert all'utente
            let alert = UIAlertController(title: "Errore", message: "URL non valido.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

            // Trova la view controller corrente e presenta l'alert
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let rootViewController = windowScene.windows.first?.rootViewController {
                rootViewController.present(alert, animated: true, completion: nil)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
