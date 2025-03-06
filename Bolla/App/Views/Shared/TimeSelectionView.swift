import SwiftUI

struct TimeSelectionView: View {
    @EnvironmentObject var bookingManager: BookingManager
    let selectedDate: Date

    // Genera gli slot orari dalle 08:00 alle 21:00
    let availableTimes: [Date] = {
        let calendar = Calendar.current
        var times: [Date] = []
        let startHour = 8
        let endHour = 21
        for hour in startHour...endHour {
            if let date = calendar.date(bySettingHour: hour, minute: 0, second: 0, of: Date()) {
                times.append(date)
            }
        }
        return times
    }()

    var body: some View {
        VStack {
            Text("Orari disponibili per \(formattedDate(selectedDate))")
                .font(.title2)
                .bold()
                .padding()

            ScrollView {
                VStack(spacing: 10) {
                    ForEach(availableTimes, id: \.self) { time in
                        HStack {
                            Text(formattedTime(time))
                                .frame(width: 100)
                                .padding()
                                .background(Color.yellow.opacity(0.3))
                                .cornerRadius(8)

                            Spacer()

                            if bookingManager.isSlotBooked(for: selectedDate, startTime: time) {
                                Text("❌ Occupato")
                                    .foregroundColor(.red)
                                    .bold()
                                    .padding()
                            } else {
                                Button(action: {
                                    bookingManager.bookSlot(date: selectedDate, startTime: time, endTime: time.addingTimeInterval(3600), student: "Studente")
                                }) {
                                    Text("Prenota")
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(Color.green)
                                        .cornerRadius(8)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }

            Spacer()
        }
        .padding()
    }

    // Formatta la data
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: date)
    }

    // Formatta l'orario
    private func formattedTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

struct TimeSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        TimeSelectionView(selectedDate: Date())
            .environmentObject(BookingManager())
    }
}
