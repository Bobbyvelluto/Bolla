import SwiftUI
import EventKit

struct AdminCalendarView: View {
    @State private var selectedDate = Date()
    @State private var selectedTime = Date()
    @State private var studentName: String = ""
    @State private var bookedSlots: [(date: Date, startTime: Date, endTime: Date, student: String)] = []
    @State private var navigateToSchedule = false
    let eventStore = EKEventStore()
    
    var body: some View {
        NavigationView {
            VStack {
                // Selezione Data (con padding azzurro dietro la data)
                DatePicker("Seleziona una data", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()
                    .background(Color.blue.opacity(0.1)) // Aggiunto un background azzurro dietro le date
                    .cornerRadius(10)
                    .shadow(radius: 5)
                
                // Selezione Orario (senza scritta "Seleziona un orario")
                DatePicker("", selection: $selectedTime, displayedComponents: .hourAndMinute)
                    .datePickerStyle(WheelDatePickerStyle())
                    .padding()
                    .background(Color.blue.opacity(0.1)) // Aggiunto un background azzurro dietro gli orari
                    .cornerRadius(10)
                    .shadow(radius: 5)

                // Campo Nome Allievo + Pulsante Prenota (campo nome arancio)
                HStack {
                    TextField("Nome Allievo", text: $studentName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .background(Color.orange.opacity(0.2)) // Background arancio per il campo nome
                        .cornerRadius(10)
                        .autocapitalization(.words)
                    
                    Button("Prenota") {
                        if !studentName.isEmpty {
                            let endTime = Calendar.current.date(byAdding: .hour, value: 1, to: selectedTime)!
                            bookedSlots.append((date: selectedDate, startTime: selectedTime, endTime: endTime, student: studentName))
                            saveEvent(for: selectedDate, start: selectedTime, end: endTime, student: studentName)
                            studentName = ""
                            navigateToSchedule = true
                        }
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                .padding()

                // Navigazione alla schermata degli orari della giornata prenotata
                NavigationLink(destination: DayScheduleView(selectedDate: selectedDate, bookedSlots: bookedSlots, isAdmin: true), isActive: $navigateToSchedule) {
                    EmptyView()
                }
                .hidden()
            }
            .padding()
        }
    }

    // Funzione per salvare l'evento nel calendario
    private func saveEvent(for date: Date, start: Date, end: Date, student: String) {
        let event = EKEvent(eventStore: eventStore)
        event.title = "Prenotato: \(student)"
        event.startDate = start
        event.endDate = end
        event.calendar = eventStore.defaultCalendarForNewEvents

        do {
            try eventStore.save(event, span: .thisEvent)
            print("Evento salvato per \(student) dalle \(formattedTime(start)) alle \(formattedTime(end))")
        } catch {
            print("Errore nel salvataggio: \(error.localizedDescription)")
        }
    }

    private func formattedTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}

struct AdminCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        AdminCalendarView()
    }
}
