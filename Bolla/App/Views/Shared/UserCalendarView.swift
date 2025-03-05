import SwiftUI
import EventKit

struct UserCalendarView: View {
    @State private var selectedDate = Date()
    @State private var bookedSlots: [(date: Date, startTime: Date, endTime: Date, student: String)] = [
        // Esempi di prenotazioni
        (date: Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date())!,
         startTime: Calendar.current.date(bySettingHour: 10, minute: 0, second: 0, of: Date())!,
         endTime: Calendar.current.date(bySettingHour: 11, minute: 0, second: 0, of: Date())!,
         student: "Mario Rossi"),
        
        (date: Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date())!,
         startTime: Calendar.current.date(bySettingHour: 15, minute: 0, second: 0, of: Date())!,
         endTime: Calendar.current.date(bySettingHour: 16, minute: 0, second: 0, of: Date())!,
         student: "Anna Bianchi")
    ]
    
    @State private var showCancelAlert = false
    @State private var slotToCancel: Date? = nil
    @State private var showBookingAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                // Selezione Data
                DatePicker("Seleziona una data", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()
                
                Text("Orari disponibili per \(formattedDate(selectedDate))")
                    .font(.headline)
                    .padding(.top)

                // Lista degli orari della giornata selezionata
                List(generateTimeSlots(), id: \.self) { slot in
                    if let booked = bookedSlots.first(where: { isSameTime($0.startTime, slot) && isSameDay($0.date, selectedDate) }) {
                        // Slot prenotato (GRIGIO con nome)
                        HStack {
                            Text("\(formattedTime(slot)) - \(booked.student)")
                                .bold()
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.gray)
                                .cornerRadius(8)
                            
                            // Icona accanto al nome dello studente
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.white)
                                .padding(.leading, 5)
                        }
                        .onTapGesture {
                            slotToCancel = slot
                            showCancelAlert = true
                        }
                    } else {
                        // Slot disponibile (VERDE)
                        HStack {
                            Text(formattedTime(slot))
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.green)
                                .cornerRadius(8)
                        }
                        .onTapGesture {
                            bookSlot(for: slot)
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
            .padding()
            .alert(isPresented: $showCancelAlert) {
                Alert(
                    title: Text("Cancella Prenotazione"),
                    message: Text("Sei sicuro di voler cancellare la prenotazione?"),
                    primaryButton: .destructive(Text("Cancella")) {
                        if let slotToCancel = slotToCancel {
                            cancelBooking(for: slotToCancel)
                        }
                    },
                    secondaryButton: .cancel()
                )
            }
            .alert(isPresented: $showBookingAlert) {
                Alert(
                    title: Text("Prenotazione Completata"),
                    message: Text("La tua prenotazione è stata completata con successo!"),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
    
    // Genera gli slot orari dalle 08:00 alle 21:00
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

    private func isSameDay(_ date1: Date, _ date2: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
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
    
    // Funzione per cancellare la prenotazione
    private func cancelBooking(for slot: Date) {
        if let index = bookedSlots.firstIndex(where: { isSameTime($0.startTime, slot) && isSameDay($0.date, selectedDate) }) {
            bookedSlots.remove(at: index)
        }
    }

    // Funzione per prenotare un orario
    private func bookSlot(for slot: Date) {
        bookedSlots.append((date: selectedDate, startTime: slot, endTime: slot.addingTimeInterval(60*60), student: "Nuovo Studente"))
        showBookingAlert = true
    }
}

// **ANTEPRIMA XCODE**
struct UserCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        UserCalendarView()
    }
}
