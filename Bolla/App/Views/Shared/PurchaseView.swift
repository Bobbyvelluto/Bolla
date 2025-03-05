import SwiftUI
import UIKit

struct PurchaseView: View {
    @State private var numberOfLessons = 0
    let lessonCost = 50
    let bonusPackCost = 230
    let bonusPackLessons = 5 // Numero di lezioni nel bonus pack

    var totalCost: Int {
        return numberOfLessons * lessonCost
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Colore di sfondo grigio scuro per riempire gli spazi vuoti
                Color(red: 0.1, green: 0.1, blue: 0.1) // Grigio scuro
                    .edgesIgnoringSafeArea(.all)

                // Immagine di sfondo "pugile" adattata allo schermo
                Image("pugile")
                    .resizable()
                    .scaledToFill() // Riempie l'intero schermo mantenendo le proporzioni
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .edgesIgnoringSafeArea(.all) // Ignora le aree sicure (notch, home indicator, ecc.)
                    .clipped() // Evita che l'immagine si estenda oltre i bordi

                VStack {
                    Spacer()

                    // Bonus Pack (primo modulo)
                    Button(action: {
                        // Apri PayPal con il bonus pack
                        openPayPal(numberOfLessons: bonusPackLessons, totalCost: bonusPackCost, isBonusPack: true)
                    }) {
                        VStack(alignment: .center) {
                            Text("Bonus Pack")
                                .font(.system(size: 32, weight: .bold, design: .default))
                                .foregroundColor(.yellow)
                                .shadow(color: .black, radius: 5)

                            Text("Acquista 5 lezioni a soli \(bonusPackCost)€!")
                                .font(.system(size: 20, weight: .medium, design: .default))
                                .foregroundColor(.white)
                                .shadow(color: .black, radius: 3)
                        }
                        .padding()
                        .background(Color.gray.opacity(0.9)) // Opacità aumentata
                        .cornerRadius(10)
                    }
                    .padding(.bottom, 20) // Spazio sotto il Bonus Pack

                    // Sezione "+" e "-" (secondo modulo)
                    HStack {
                        Button(action: {
                            if numberOfLessons > 0 {
                                numberOfLessons -= 1
                            }
                        }) {
                            Image(systemName: "minus.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(.red)
                                .padding(.horizontal, 10)
                        }

                        Text("\(numberOfLessons) Lezioni")
                            .font(.system(size: 24, weight: .medium, design: .default))
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 3)
                            .padding(.horizontal, 10)

                        Button(action: {
                            numberOfLessons += 1
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(.green)
                                .padding(.horizontal, 10)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color.gray.opacity(0.8)) // Opacità aumentata (meno trasparente)
                    .cornerRadius(10)
                    .padding(.bottom, 20) // Spazio sotto la sezione "+" e "-"

                    // Costo Totale e pulsante "Acquista" (terzo modulo)
                    HStack {
                        Text("\(totalCost)€")
                            .font(.system(size: 28, weight: .semibold, design: .default))
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 5)
                            .padding(.horizontal, 15)
                            .padding(.vertical, 8)
                            .background(Color.green.opacity(0.7))
                            .cornerRadius(8)

                        // Pulsante "Acquista"
                        Button(action: {
                            // Apri PayPal quando l'utente clicca su "Acquista"
                            openPayPal(numberOfLessons: numberOfLessons, totalCost: totalCost, isBonusPack: false)
                        }) {
                            Text("Acquista")
                                .font(.system(size: 18, weight: .semibold, design: .default))
                                .foregroundColor(.white)
                                .shadow(color: .black, radius: 3)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .background(numberOfLessons > 0 ? Color.green.opacity(0.7) : Color.gray.opacity(0.8)) // Opacità aumentata
                                .cornerRadius(8)
                        }
                        .disabled(numberOfLessons == 0) // Disabilita il pulsante se numberOfLessons è 0
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color.gray.opacity(0.6)) // Opacità aumentata
                    .cornerRadius(10)
                    .padding(.bottom, -35) // Spazio in basso
                }
                .padding()

                // Pulsante "Back" in alto a sinistra (solo l'icona verde con la freccia)
                VStack {
                    HStack {
                        // Utilizza un semplice Button per tornare indietro
                        Button(action: {
                            // Azione per tornare indietro
                            // Puoi usare una variabile di stato o un'azione personalizzata
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.green.opacity(0.7))
                                .cornerRadius(10)
                        }
                        .padding(.leading, 24)
                        .padding(.top, 20)
                        Spacer()
                    }
                    Spacer()
                }
            }
        }
    }

    // Funzione per aprire PayPal
    func openPayPal(numberOfLessons: Int, totalCost: Int, isBonusPack: Bool) {
        let paypalEmail = "wilsonbasetta@example.com" // Sostituisci con la tua email PayPal
        let currencyCode = "EUR" // Codice valuta (Euro)
        let itemName = isBonusPack ? "Bonus Pack (5 Lezioni)" : "Lezioni di Boxe" // Nome dell'oggetto acquistato (diverso per il bonus pack)

        // Crea l'URL di PayPal
        let paypalURLString = "https://www.paypal.com/cgi-bin/webscr?cmd=_xclick&business=\(paypalEmail)&amount=\(Double(totalCost))¤cy_code=\(currencyCode)&item_name=\(itemName)"

        // Codifica l'URL per gestire spazi e caratteri speciali
        guard let encodedURLString = paypalURLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let paypalURL = URL(string: encodedURLString) else {
            print("Errore: URL non valido")
            return
        }

        // Apri l'URL
        UIApplication.shared.open(paypalURL, options: [:], completionHandler: nil)
    }
}

struct PurchaseView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseView()
    }
}
