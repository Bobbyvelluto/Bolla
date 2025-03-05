import SwiftUI

struct CalendarView: View {
    @ObservedObject var calendarModel: CalendarModel // Riceve il modello del calendario

    var body: some View {
        VStack {
            // Selezione anno e mese
            HStack {
                Picker("Anno", selection: $calendarModel.selectedYear) {
                    ForEach(2020..<2030, id: \.self) { year in
                        Text("\(year)").tag(year)
                    }
                }
                .pickerStyle(MenuPickerStyle())

                Picker("Mese", selection: $calendarModel.selectedMonth) {
                    ForEach(1..<13, id: \.self) { month in
                        Text("\(month)").tag(month)
                    }
                }
                .pickerStyle(MenuPickerStyle())
            }
            .padding()

            // Griglia dei giorni
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 10) {
                ForEach(calendarModel.days) { day in
                    Button(action: {
                        calendarModel.selectedDay = day
                    }) {
                        Text("\(day.day)")
                            .frame(width: 40, height: 40)
                            .background(calendarModel.selectedDay?.id == day.id ? Color.blue : Color.gray.opacity(0.2))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
            }
            .padding()

            // Orari disponibili per il giorno selezionato
            if let selectedDay = calendarModel.selectedDay {
                Text("Orari disponibili per il \(selectedDay.day)/\(calendarModel.selectedMonth)/\(calendarModel.selectedYear)")
                    .font(.headline)
                    .padding()

                List(selectedDay.availableHours, id: \.self) { hour in
                    Text(hour.formatted(date: .omitted, time: .shortened))
                }
            } else {
                Text("Seleziona un giorno")
                    .font(.headline)
                    .padding()
            }
        }
        .onChange(of: calendarModel.selectedYear) { _ in
            calendarModel.generateDaysForMonth()
        }
        .onChange(of: calendarModel.selectedMonth) { _ in
            calendarModel.generateDaysForMonth()
        }
    }
}
