import SwiftUI

struct AdminCalendarView: View {
    @State private var selectedDate: Date = Date()
    @State private var selectedDay: Date?
    @State private var bookedSlots: [Date: Bool] = [:]  // Memorizza gli slot occupati
    @State private var selectedTime: Date = Date()
    @State private var enteredName: String = ""

    // Funzione per ottenere tutti i giorni del mese corrente
    private func getDaysInMonth(for date: Date) -> [Day] {
        let calendar = Calendar.current
        let range = calendar.range(of: .day, in: .month, for: date)!
        let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: date))!
        
        return range.map { day -> Day in
            let date = calendar.date(byAdding: .day, value: day - 1, to: firstDayOfMonth)!
            return Day(day: day, date: date)
        }
    }

    // Modifica la data e mese
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date)
    }

    // Struttura per ogni giorno
    struct Day: Identifiable {
        var id = UUID()
        var day: Int
        var date: Date
    }

    var body: some View {
        VStack {
            // Intestazione con il titolo
            Text("Admin Calendar")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
                .background(Color.green)
                .cornerRadius(10)
                .foregroundColor(.white)
            
            // Data e mese
            Text(formattedDate(selectedDate))
                .font(.title)
                .padding()

            // Griglia del calendario con giorni
            let days = getDaysInMonth(for: selectedDate)
            let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 7)
            
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(days) { day in
                    Text("\(day.day)")
                        .font(.system(size: 14))  // Numero dei giorni più piccolo
                        .padding()
                        .frame(width: 50, height: 50)  // Ingrandisce i quadrati
                        .background(bookedSlots.keys.contains(day.date) ? Color.red : Color.blue)
                        .cornerRadius(8)
                        .foregroundColor(.yellow)  // Colore giallo per i numeri dei giorni
                        .onTapGesture {
                            selectDay(day.date)
                        }
                }
            }
            .padding()

            Spacer() // Rende lo spazio disponibile tra il calendario e il modulo orario/nome/pulsante

            // Moduli per orario, nome e prenotazione
            VStack {
                Picker("", selection: $selectedTime) {
                    ForEach(0..<24, id: \.self) { hour in
                        ForEach(0..<60, id: \.self) { minute in
                            let time = Calendar.current.date(bySettingHour: hour, minute: minute, second: 0, of: Date())!
                            Text(formattedTime(time)).tag(time)
                        }
                    }
                }
                .pickerStyle(WheelPickerStyle())  // Stile a ruota per il Picker
                .frame(height: 200)

                TextField("Inserisci il nome", text: $enteredName)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.bottom, 0)

                Button(action: {
                    bookSlot()
                }) {
                    Text("Prenota")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding(.top, -20) // Aumentato il padding per spostare più in alto
            .padding(.horizontal)
        }
    }

    // Funzione per formattare l'orario
    private func formattedTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }

    // Funzione per selezionare un giorno
    private func selectDay(_ date: Date) {
        selectedDay = date
    }

    // Funzione per prenotare uno slot
    private func bookSlot() {
        guard let selectedDay = selectedDay, !enteredName.isEmpty else {
            return
        }

        let calendar = Calendar.current
        let fullDate = calendar.date(bySettingHour: calendar.component(.hour, from: selectedTime), minute: calendar.component(.minute, from: selectedTime), second: 0, of: selectedDay)!

        // Salva lo slot prenotato
        bookedSlots[fullDate] = true
        self.selectedDay = nil  // Resetta la selezione del giorno
    }
}

struct AdminCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        AdminCalendarView()
    }
}
