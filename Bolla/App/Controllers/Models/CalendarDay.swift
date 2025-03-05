import Foundation

struct CalendarDay: Identifiable {
    let id = UUID()
    let day: Int
    let date: Date
    var availableHours: [Date] // Orari disponibili per il giorno
}

class CalendarModel: ObservableObject {
    @Published var selectedYear: Int = Calendar.current.component(.year, from: Date())
    @Published var selectedMonth: Int = Calendar.current.component(.month, from: Date())
    @Published var selectedDay: CalendarDay?
    @Published var days: [CalendarDay] = []

    init() {
        generateDaysForMonth()
    }

    // Genera i giorni del mese selezionato
    func generateDaysForMonth() {
        let calendar = Calendar.current
        let dateComponents = DateComponents(year: selectedYear, month: selectedMonth)
        guard let date = calendar.date(from: dateComponents) else { return }

        let range = calendar.range(of: .day, in: .month, for: date)!
        let daysInMonth = range.count

        days = (1...daysInMonth).map { day in
            let date = calendar.date(from: DateComponents(year: selectedYear, month: selectedMonth, day: day))!
            let availableHours = generateAvailableHours(for: date)
            return CalendarDay(day: day, date: date, availableHours: availableHours)
        }
    }

    // Genera orari disponibili per un giorno specifico
    func generateAvailableHours(for date: Date) -> [Date] {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        var availableHours: [Date] = []

        for hour in 9..<18 { // Dalle 9:00 alle 17:00
            if let hourDate = calendar.date(byAdding: .hour, value: hour, to: startOfDay) {
                availableHours.append(hourDate)
            }
        }

        return availableHours
    }
}
