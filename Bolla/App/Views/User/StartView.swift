import SwiftUI

struct StartView: View {
    var body: some View {
        ZStack {
            // Immagine di sfondo "sfondo2"
            Image("sfondo2")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .scaledToFill()

            // PurchaseView
            PurchaseView()
        }
    }
}
