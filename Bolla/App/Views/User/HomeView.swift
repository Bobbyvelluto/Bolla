import SwiftUI
import UIKit

struct HomeView: View {
    @State private var isCalendarViewPresented: Bool = false

    var body: some View {
        NavigationStack {
            ZStack {
                // Immagine di sfondo "Sfondofico"
                Image("Sfondofico")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()

                // Fila di icone in basso con scorrimento orizzontale
                VStack {
                    Spacer()

                    // ScrollView orizzontale per le icone
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) { // Spazio tra le icone
                            // Icona "start" con etichetta
                            IconWithLabelView<PurchaseView>(
                                imageName: "start",
                                label: "Let's Start!",
                                destination: PurchaseView() // Naviga direttamente a PurchaseView
                            )

                            // Icona "prenota" con etichetta
                            IconWithLabelView<EmptyView>(
                                imageName: "prenota",
                                label: "Book Now",
                                action: {
                                    isCalendarViewPresented = true
                                    print("Prenota tapped!")
                                }
                            )

                            // Icona "contact" con etichetta
                            IconWithLabelView<EmptyView>(
                                imageName: "contact",
                                label: "Contact",
                                action: {
                                    openWhatsApp(phoneNumber: "3355405933")
                                    print("Contact tapped!")
                                }
                            )

                            // Icona "the book" con etichetta
                            IconWithLabelView<EmptyView>(
                                imageName: "libro",
                                label: "The Book",
                                action: {
                                    openURL(urlString: "https://www.amazon.it/Boxe-Gleasons-Gym-Ediz-illustrata/dp/8827226850")
                                    print("The book tapped!")
                                }
                            )

                            // Icona "shop" con etichetta
                            IconWithLabelView<EmptyView>(
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
                UserCalendarView() // Mostra la vista del calendario
            }
        }
    }
}

// Estensione per le funzioni di utilità
extension HomeView {
    // Funzione per aprire WhatsApp
    private func openWhatsApp(phoneNumber: String) {
        let formattedNumber = phoneNumber.replacingOccurrences(of: " ", with: "")
        guard let whatsappURL = URL(string: "https://api.whatsapp.com/send?phone=\(formattedNumber)") else {
            showAlert(title: "Errore", message: "Numero di telefono non valido.")
            return
        }

        if UIApplication.shared.canOpenURL(whatsappURL) {
            UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
        } else {
            showAlert(title: "WhatsApp", message: "WhatsApp non è installato.")
        }
    }

    // Funzione per aprire un URL
    private func openURL(urlString: String) {
        guard let url = URL(string: urlString) else {
            showAlert(title: "Errore", message: "URL non valido.")
            return
        }

        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            showAlert(title: "Errore", message: "Impossibile aprire l'URL.")
        }
    }

    // Funzione per mostrare un alert
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            rootViewController.present(alert, animated: true, completion: nil)
        }
    }
}

// Vista per un'icona con etichetta
struct IconWithLabelView<Destination: View>: View {
    let imageName: String
    let label: String
    var action: (() -> Void)? = nil
    var destination: Destination? = nil

    var body: some View {
        VStack {
            if let action = action {
                Button(action: action) {
                    IconView(imageName: imageName, width: 50, height: 60)
                }
            } else if let destination = destination {
                NavigationLink(destination: destination) {
                    IconView(imageName: imageName, width: 50, height: 60)
                }
            } else {
                IconView(imageName: imageName, width: 50, height: 60)
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
}

// Vista per un'icona riutilizzabile
struct IconView: View {
    let imageName: String
    let width: CGFloat
    let height: CGFloat

    var body: some View {
        Image(imageName)
            .resizable()
            .frame(width: width, height: height)
            .padding(10)
            .background(Color.blue.opacity(0.4))
            .clipShape(Circle())
    }
}

// Preview
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
