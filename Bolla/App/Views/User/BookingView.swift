import SwiftUI

struct BookingView: View {
    let lesson: Lesson

    var body: some View {
        VStack {
            Text("Prenotazione per \(lesson.date.formatted())")
            if lesson.status == .pending {
                Text("In attesa di conferma")
            } else if lesson.status == .confirmed {
                Text("Confermato")
            } else {
                Text("Rifiutato")
            }
        }
    }
}

// Definizione del modello Lesson
struct Lesson: Identifiable {
    let id: UUID
    let date: Date
    let status: LessonStatus
}

// Definizione dell'enum LessonStatus
enum LessonStatus: String {
    case pending = "In attesa di conferma"
    case confirmed = "Confermato"
    case rejected = "Rifiutato"
}

// Anteprima
struct BookingView_Previews: PreviewProvider {
    static var previews: some View {
        BookingView(lesson: Lesson(
            id: UUID(),
            date: Date(),
            status: .pending
        ))
    }
}
