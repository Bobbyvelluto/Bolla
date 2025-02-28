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

                // Testo "WBBS" e "WELCOME" con contorno nero
                VStack {
                    Text("WBBS")
                        .font(.custom("Impact", size: 70).italic())
                        .foregroundColor(.white) // Colore del testo
                        .shadow(color: .black, radius: 5, x: 0, y: 5)
                        .padding(10) // Padding per il testo
                        .background(Color.green.opacity(0.7)) // Sfondo verde trasparente
                        .overlay(
                            RoundedRectangle(cornerRadius: 0)
                                .stroke(.black, lineWidth: 2) // Contorno nero di 2 punti
                        )

                    Text("WELCOME")
                        .font(.custom("Impact", size: 30).italic())
                        .foregroundColor(.white) // Colore del testo
                        .shadow(color: .black, radius: 5, x: 0, y: 5)
                        .padding(10) // Padding per il testo
                        .background(Color.green.opacity(0.7)) // Sfondo verde trasparente
                        .overlay(
                            RoundedRectangle(cornerRadius: 0)
                                .stroke(.black, lineWidth: 2) // Contorno nero di 2 punti
                        )
                }
                .padding(.top, -390) // Mantenuto

                // Fila di icone in basso con scorrimento orizzontale
                VStack {
                    Spacer()

                    // ScrollView orizzontale per le icone
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) { // Spazio tra le icone
                            // Icona "start" con etichetta
                            iconWithLabel(
                                imageName: "start",
                                label: "Let's Start!",
                                action: {
                                    // Azione per "start"
                                },
                                isNavigationLink: true
                            )

                            // Icona "prenota" con etichetta
                            iconWithLabel(
                                imageName: "prenota",
                                label: "Book Now",
                                action: {
                                    isCalendarViewPresented = true
                                    print("Prenota tapped!")
                                }
                            )

                            // Icona "contact" con etichetta
                            iconWithLabel(
                                imageName: "contact",
                                label: "Contact",
                                action: {
                                    openWhatsApp(phoneNumber: "3355405933")
                                    print("Contact tapped!")
                                }
                            )

                            // Icona "the book" con etichetta
                            iconWithLabel(
                                imageName: "libro",
                                label: "The Book",
                                action: {
                                    openURL(urlString: "https://www.amazon.it/Boxe-Gleasons-Gym-Ediz-illustrata/dp/8827226850")
                                    print("The book tapped!")
                                }
                            )

                            // Icona "shop" con etichetta
                            iconWithLabel(
                                imageName: "shop",
                                label: "Shop",
                                action: {
                                    openURL(urlString: "https://wilsonbasetta.wixsite.com/wilsonbasetta/about-1")
                                    print("Shop tapped!")
                                }
                            )
                        }
                        .padding(.horizontal, 20) // Padding laterale per evitare che le icone tocchino i bordi
                    }
                    .padding(.bottom, 20) // Spazio dal bordo inferiore
                }
            }
            .sheet(isPresented: $isCalendarViewPresented) {
                CalendarView()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    // Funzione per creare una vista icona con etichetta e rettangolo di sfondo
    func iconWithLabel(imageName: String, label: String, action: @escaping () -> Void, isNavigationLink: Bool = false) -> some View {
        VStack {
            if isNavigationLink {
                NavigationLink(destination: StartView()) {
                    iconView(imageName: imageName, width: 50, height: 60)
                }
            } else {
                Button(action: action) {
                    iconView(imageName: imageName, width: 50, height: 60)
                }
            }
            Text(label)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.white)
                .shadow(color: .black, radius: 2, x: 0, y: 2)
        }
        .padding(10) // Padding interno
        .background(
            RoundedRectangle(cornerRadius: 10) // Rettangolo con angoli arrotondati
                .fill(Color.blue.opacity(0.4)) // Colore di sfondo
        )
    }

    // Funzione per creare una vista icona riutilizzabile
    func iconView(imageName: String, width: CGFloat, height: CGFloat) -> some View {
        Image(imageName)
            .resizable()
            .frame(width: width, height: height)
            .padding(10)
            .background(Color.blue.opacity(0.4))
            .clipShape(Circle())
    }

    // Funzione per aprire WhatsApp
    func openWhatsApp(phoneNumber: String) {
        let whatsappURL = URL(string: "https://api.whatsapp.com/send?phone=\(phoneNumber)")

        if UIApplication.shared.canOpenURL(whatsappURL!) {
            UIApplication.shared.open(whatsappURL!, options: [:], completionHandler: nil)
        } else {
            print("WhatsApp non è installato!")
            let alert = UIAlertController(title: "WhatsApp", message: "WhatsApp non è installato.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

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
            print("URL non valido!")
            let alert = UIAlertController(title: "Errore", message: "URL non valido.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

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
