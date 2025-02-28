import SwiftUI

struct PurchaseView: View {
    @State private var numberOfLessons = 0
    let lessonCost = 50
    let bonusPackCost = 230

    var totalCost: Int {
        return numberOfLessons * lessonCost
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Immagine di sfondo "paypal" adattata allo schermo
                Image("paypal")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .edgesIgnoringSafeArea(.all)
                    .offset(y: 40) // Abbassa l'immagine di 50 punti

                VStack {
                    // "ACQUISTA LE TUE LEZIONI" con padding verde trasparente
                    Text("ACQUISTA LE TUE LEZIONI")
                        .font(.system(size: 26, weight: .bold, design: .default))
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 5)
                        .padding()
                        .background(Color.green.opacity(0.7))
                        .cornerRadius(10)
                        .padding(.top, -20) // Alzata di 30 punti (era 50)
                        .frame(maxWidth: .infinity, alignment: .center)

                    Spacer()

                    // Resto del contenuto in basso
                    VStack {
                        // Sezione "+" e "-" con rettangolo
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
                        .background(Color.gray.opacity(0.6))
                        .cornerRadius(10)
                        .padding(.bottom, 10)

                        // Costo Totale con rettangolo e pulsante "Acquista"
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
                                openPayPal(numberOfLessons: numberOfLessons, totalCost: totalCost)
                            }) {
                                Text("Acquista")
                                    .font(.system(size: 18, weight: .semibold, design: .default))
                                    .foregroundColor(.white)
                                    .shadow(color: .black, radius: 3)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                                    .background(numberOfLessons > 0 ? Color.green.opacity(0.7) : Color.gray.opacity(0.7))
                                    .cornerRadius(8)
                            }
                            .disabled(numberOfLessons == 0) // Disabilita il pulsante se numberOfLessons è 0
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(Color.gray.opacity(0.4))
                        .cornerRadius(10)
                        .padding(.bottom, 20)

                        // Bonus Pack
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
                        .background(Color.gray.opacity(0.8))
                        .cornerRadius(10)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.bottom, 2)
                }
                .padding()
            }
        }
        .navigationBarHidden(true) // Nascondi la barra di navigazione
    }

    // Funzione per aprire PayPal
    func openPayPal(numberOfLessons: Int, totalCost: Int) {
        let paypalEmail = "wilsonbasetta@example.com" // Sostituisci con la tua email PayPal
        let currencyCode = "EUR" // Codice valuta (Euro)
        let itemName = "Lezioni di Boxe" // Nome dell'oggetto acquistato

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
