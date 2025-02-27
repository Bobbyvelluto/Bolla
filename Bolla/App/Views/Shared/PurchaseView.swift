import SwiftUI

struct PurchaseView: View {
    @State private var numberOfLessons = 0
    let lessonCost = 50
    let bonusPackCost = 230

    var totalCost: Int {
        return numberOfLessons * lessonCost
    }

    var body: some View {
        ZStack {
            // Immagine di sfondo "paypal" adattata allo schermo
            Image("paypal")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)

            VStack {
                // "ACQUISTA LE TUE LEZIONI" con padding verde trasparente
                Text("ACQUISTA LE TUE LEZIONI")
                    .font(.system(size: 26, weight: .bold, design: .default))
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 5)
                    .padding() // Aggiunto padding intorno al testo
                    .background(Color.green.opacity(0.3)) // Aggiunto sfondo verde trasparente
                    .cornerRadius(10) // Aggiunti angoli arrotondati
                    .padding(.top, 50) // Spazio dal bordo superiore
                    .frame(maxWidth: .infinity, alignment: .center) // Allineamento al centro
                
                Spacer() // Spazio per spingere il resto del contenuto in basso

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
                                .padding(.horizontal, 10) // Aggiunto padding orizzontale
                        }

                        Text("\(numberOfLessons) Lezioni")
                            .font(.system(size: 24, weight: .medium, design: .default))
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 3)
                            .padding(.horizontal, 10) // Ridotto il padding orizzontale

                        Button(action: {
                            numberOfLessons += 1
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(.green)
                                .padding(.horizontal, 10) // Aggiunto padding orizzontale
                        }
                    }
                    .padding(.horizontal, 20) // Aggiunto padding orizzontale
                    .padding(.vertical, 10) // Aggiunto padding verticale
                    .background(Color.gray.opacity(0.6)) // Aggiunto sfondo grigio trasparente
                    .cornerRadius(10) // Aggiunti angoli arrotondati
                    .padding(.bottom, 10) // *RIDOTTO* Spazio dal bordo inferiore

                    // Costo Totale con rettangolo e importo in casella separata
                    HStack {
                        Text("Costo Totale:")
                            .font(.system(size: 28, weight: .semibold, design: .default))
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 5)

                        Text("\(totalCost)€")
                            .font(.system(size: 28, weight: .semibold, design: .default))
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 5)
                            .padding(.horizontal, 15) // Aggiunto padding orizzontale
                            .padding(.vertical, 8) // Aggiunto padding verticale
                            .background(Color.gray.opacity(0.8)) // Aggiunto sfondo grigio scuro
                            .cornerRadius(8) // Aggiunti angoli arrotondati
                    }
                    .padding(.horizontal, 20) // Aggiunto padding orizzontale
                    .padding(.vertical, 10) // Aggiunto padding verticale
                    .background(Color.gray.opacity(0.4)) // Aggiunto sfondo grigio trasparente
                    .cornerRadius(10) // Aggiunti angoli arrotondati
                    .padding(.bottom, 20) // *RIDOTTO* Spazio dal bordo inferiore

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
                .frame(maxWidth: .infinity, alignment: .center) // Allineamento al centro
                .padding(.bottom, 2) // Spazio dal bordo inferiore
            }
            .padding()
        }
    }
}

struct PurchaseView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseView()
    }
}
