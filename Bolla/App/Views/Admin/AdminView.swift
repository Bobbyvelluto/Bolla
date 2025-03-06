import SwiftUI

struct AdminView: View {
    @State private var availableSlots: [(date: Date, startTime: Date, endTime: Date)] = []

    var body: some View {
        VStack {
            Text("Gestione Admin")
                .font(.largeTitle)
                .padding()

            List {
                ForEach(availableSlots, id: \.self.startTime) { slot in
                    HStack {
                        Text("\(formattedDate(slot.date)) - \(formattedTime(slot.startTime)) / \(formattedTime(slot.endTime))")
                        Spacer()
                        Button(action: {
                            removeSlot(slot)
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                    }
                }
            }

            Button(action: {
                addSlot()
            }) {
                Text("Aggiungi Disponibilità")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
        }
        .padding()
    }

    private func addSlot() {
        let newDate = Date()
        let startTime = Calendar.current.date(bySettingHour: 10, minute: 0, second: 0, of: newDate)!
        let endTime = Calendar.current.date(byAdding: .hour, value: 1, to: startTime)!

        availableSlots.append((date: newDate, startTime: startTime, endTime: endTime))
    }

    private func removeSlot(_ slot: (date: Date, startTime: Date, endTime: Date)) {
        availableSlots.removeAll { $0.startTime == slot.startTime }
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: date)
    }

    private func formattedTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}

struct AdminView_Previews: PreviewProvider {
    static var previews: some View {
        AdminView()
    }
}
