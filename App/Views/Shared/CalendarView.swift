import SwiftUI

struct CalendarView: View {
    // Esempio di dati (dovrebbe venire dall'API)
    @State private var availableDates: [Date] = []
    @State private var bookedDates: [Date] = []
    @State private var selectedDate: Date? = nil
    @State private var selectedTime: Date? = nil // NUOVA variabile per l'ora selezionata
    @State private var availableTimes: [Date] = [] // NUOVA variabile per gli orari disponibili

    @Environment(\.presentationMode) var presentationMode

    //Stato per mostrare un messaggio di conferma
    @State private var showingConfirmation = false

    //Formato data per visualizzare le date in modo leggibile
    let dateFormatter = DateFormatter()
    let timeFormatter = DateFormatter() // NUOVO formattatore per l'ora

    //Usiamo un oggetto Calendar per manipolare le date
    let calendar = Calendar.current
    //Data di partenza del calendario (questo mese)
    @State private var currentDate = Date()

    var body: some View {
        VStack {
            Text("Seleziona una data e un'ora")
                .font(.title)
                .padding(.top)

            //Header del calendario (mese e anno)
            HStack {
                Button(action: {
                    //Torna al mese precedente
                    currentDate = calendar.date(byAdding: .month, value: -1, to: currentDate) ?? Date()
                    loadDates() //Ricarica le date quando si cambia mese
                }) {
                    Image(systemName: "chevron.left")
                }
                Spacer()
                Text(formatMonthYear(date: currentDate)) // Usa la funzione per formattare mese e anno
                    .font(.headline)
                Spacer()
                Button(action: {
                    //Avanza al mese successivo
                    currentDate = calendar.date(byAdding: .month, value: 1, to: currentDate) ?? Date()
                    loadDates() //Ricarica le date quando si cambia mese
                }) {
                    Image(systemName: "chevron.right")
                }
            }
            .padding(.horizontal)

            //Visualizzazione del calendario
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
                //Nomi dei giorni della settimana
                ForEach(dateFormatter.shortWeekdaySymbols, id: \.self) { weekday in
                    Text(weekday)
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }

                //Date del mese
                ForEach(getDatesInMonth(date: currentDate), id: \.self) { date in
                    let day = calendar.component(.day, from: date)
                    let isAvailable = availableDates.contains(date)
                    let isBooked = bookedDates.contains(date)

                    Button(action: {
                        if isAvailable && !isBooked {
                            selectedDate = date
                            selectedTime = nil // Reset dell'ora quando si seleziona una nuova data
                            loadAvailableTimes(for: date) // Carica gli orari disponibili per la data
                        }
                    }) {
                        Text("\(day)")
                            .font(.system(size: 16))
                            .foregroundColor(isBooked ? .gray : (isAvailable ? .green : .black)) //Verde se disponibile, grigio se occupato, nero altrimenti
                            .padding(8)
                            .frame(width: 30, height: 30)
                            .background(
                                Circle()
                                    .fill(isBooked ? Color.gray.opacity(0.3) : (selectedDate == date ? Color.blue.opacity(0.3) : Color.clear)) //Evidenzia la data selezionata in blu
                            )
                    }
                    .disabled(isBooked || !isAvailable) //Disabilita i giorni occupati o non disponibili
                }
            }
            .padding(.horizontal)

            // Selezione dell'orario (NUOVA SEZIONE)
            if let selectedDate = selectedDate {
                Text("Seleziona un orario:")
                    .font(.headline)
                    .padding(.top)

                ScrollView(.horizontal) {
                    HStack {
                        ForEach(availableTimes, id: \.self) { time in
                            Button(action: {
                                selectedTime = time
                            }) {
                                Text(timeFormatter.string(from: time))
                                    .padding(8)
                                    .background(selectedTime == time ? Color.blue : Color.gray.opacity(0.3))
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }

            // Pulsante "Prenota" (MOSTRATO SOLO SE DATA E ORA SONO SELEZIONATE)
            if selectedDate != nil && selectedTime != nil {
                Button("Prenota"){
                    //AZIONE DI PRENOTAZIONE - qui dovresti chiamare la tua API
                    //Per ora simuliamo un messaggio di conferma
                    showingConfirmation = true
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .alert(isPresented: $showingConfirmation){
                    Alert(
                        title: Text("Prenotazione effettuata!"),
                        message: Text("La tua lezione è stata prenotata per il \(dateFormatter.string(from: selectedDate!)) alle \(timeFormatter.string(from: selectedTime!))"),
                        dismissButton: .default(Text("OK")) {
                            //AZIONE DOPO LA CONFERMA (es: ricaricare le date)
                            //Per ora chiudiamo solo la vista
                            presentationMode.wrappedValue.dismiss()
                        }
                    )
                }
            }

            Spacer() //Spazio in basso
            Button("Chiudi") {
                presentationMode.wrappedValue.dismiss()
            }
            .padding(.bottom)
        }
        .onAppear {
            //Configura il formato della data
            dateFormatter.dateFormat = "dd/MM/yyyy" // Solo la data
            dateFormatter.locale = Locale(identifier: "it_IT") //Formato italiano

            //Configura il formato dell'ora
            timeFormatter.dateFormat = "HH:mm" // Solo l'ora
            timeFormatter.locale = Locale(identifier: "it_IT")

            loadDates()
        }
    }

    //Funzione per formattare il mese e l'anno
    func formatMonthYear(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy" // "yyyy" per l'anno a 4 cifre
        formatter.locale = Locale(identifier: "it_IT")
        return formatter.string(from: date)
    }


    //Funzione asincrona per caricare le date disponibili e prenotate dall'API
    func loadDates(){
        //SIMULAZIONE DATI - DA SOSTITUIRE CON CHIAMATE API
        //Qui dovresti chiamare la tua API per ottenere le date disponibili/occupate
        //Per ora, popoliamo con date di esempio
        var tempAvailableDates: [Date] = []
        var tempBookedDates: [Date] = []

        //Genera alcune date casuali per il mese corrente
        let calendar = Calendar.current
        let components = DateComponents(year: calendar.component(.year, from: currentDate), month: calendar.component(.month, from: currentDate))
        guard let startOfMonth = calendar.date(from: components) else { return }

        for i in 1...10{
            if let randomDate = calendar.date(byAdding: .day, value: Int.random(in: 1...28), to: startOfMonth){
                tempAvailableDates.append(randomDate)
            }
        }

        for i in 1...5{
            if let randomDate = calendar.date(byAdding: .day, value: Int.random(in: 1...28), to: startOfMonth){
                tempBookedDates.append(randomDate)
            }
        }

        //Aggiorna lo stato con le date simulate
        availableDates = tempAvailableDates
        bookedDates = tempBookedDates
    }

    //Funzione per generare gli orari disponibili (SIMULAZIONE)
    func loadAvailableTimes(for date: Date) {
        var tempAvailableTimes: [Date] = []
        let calendar = Calendar.current

        // Definisci gli orari di inizio e fine (es. 9:00 - 17:00)
        let startHour = 9
        let endHour = 17

        // Itera attraverso gli orari e crea le date
        for hour in startHour...endHour {
            var components = calendar.dateComponents([.year, .month, .day], from: date)
            components.hour = hour
            components.minute = 0

            if let time = calendar.date(from: components) {
                tempAvailableTimes.append(time)
            }
        }

        availableTimes = tempAvailableTimes
    }

    //Funzione per generare le date di un mese
    func getDatesInMonth(date: Date) -> [Date] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: date) else {
            return []
        }
        let monthStartDate = monthInterval.start
        let monthEndDate = monthInterval.end

        var dates: [Date] = []
        var current = monthStartDate
        while current < monthEndDate {
            dates.append(current)
            guard let nextDay = calendar.date(byAdding: .day, value: 1, to: current) else {
                break
            }
            current = nextDay
        }
        return dates
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
