import SwiftUI

struct CalendarView: View {
    // Esempio di dati (dovrebbe venire dall'API)
    @State private var availableDates: [Date] = []
    @State private var bookedDates: [Date] = []
    @State private var selectedDate: Date? = nil

    @Environment(\.presentationMode) var presentationMode

    //Stato per mostrare un messaggio di conferma
    @State private var showingConfirmation = false

    //Formato data per visualizzare le date in modo leggibile
    let dateFormatter = DateFormatter()

    //Usiamo un oggetto Calendar per manipolare le date
    let calendar = Calendar.current
    //Data di partenza del calendario (questo mese)
    @State private var currentDate = Date()

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
                Text("\(dateFormatter.monthSymbols[calendar.component(.month, from: currentDate) - 1]) \(calendar.component(.year, from: currentDate))")
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

            if let selectedDate = selectedDate {
                Text("Data selezionata: \(dateFormatter.string(from: selectedDate))")
                    .padding()

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
                        message: Text("La tua lezione è stata prenotata per il \(dateFormatter.string(from: selectedDate))"),
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
            dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
            dateFormatter.locale = Locale(identifier: "it_IT") //Formato italiano
            loadDates()
        }
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
        let startOfMonth = calendar.date(from: components)!

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
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
