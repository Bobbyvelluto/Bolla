import SwiftUI

struct DayScheduleView: View {
    let selectedDate: Date
    let bookedSlots: [(date: Date, startTime: Date, endTime: Date, student: String)]
    let isAdmin: Bool
    
    var body: some View {
        VStack {
            Text("Orari del \(formattedDate(selectedDate))")
                .font(.title)
                .padding()
            
            List(generateTimeSlots(), id: \.self) { slot in
                if let booked = bookedSlots.first(where: { isSameTime($0.startTime, slot) }) {
                    // Se l'orario è prenotato, appare grigio e mostra il nome dello studente (solo per l'admin)
                    HStack {
                        Text("\(formattedTime(slot)) - \(isAdmin ? booked.student : "Non disponibile")")
                            .bold()
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.gray)
                            .cornerRadius(8)
                    }
                } else {
                    // Se l'orario è libero, appare verde
                    HStack {
                        Text(formattedTime(slot))
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .cornerRadius(8)
                    }
                }
            }
            .listStyle(PlainListStyle())
        }
        .padding()
    }

    // Genera gli slot di orario disponibili dalle 08:00 alle 21:00 (1 ora ciascuno)
    private func generateTimeSlots() -> [Date] {
        var slots: [Date] = []
        let calendar = Calendar.current
        var currentTime = calendar.date(bySettingHour: 8, minute: 0, second: 0, of: selectedDate)!

        while currentTime < calendar.date(bySettingHour: 21, minute: 0, second: 0, of: selectedDate)! {
            slots.append(currentTime)
            currentTime = calendar.date(byAdding: .hour, value: 1, to: currentTime)!
        }
        return slots
    }

    private func isSameTime(_ date1: Date, _ date2: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.component(.hour, from: date1) == calendar.component(.hour, from: date2)
    }

    private func formattedTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: date)
    }
}

struct DayScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        DayScheduleView(selectedDate: Date(), bookedSlots: [(date: Date(), startTime: Date(), endTime: Date(), student: "Mario Rossi")], isAdmin: true)
    }
}
