import SwiftUI

struct CalendarView: View {
    var body: some View {
        ZStack {
            // Immagine di sfondo "Sfondofico"
            Image("Sfondofico")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .scaledToFill()

            // Calendario (puoi usare una libreria esterna o creare il tuo)
            // Esempio:
            Text("Calendario placeholder")
                .font(.largeTitle)
                .foregroundColor(.white)
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
