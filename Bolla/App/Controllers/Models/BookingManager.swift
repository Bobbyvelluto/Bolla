import SwiftUI

// Booking Manager to handle the booking logic
class BookingManager: ObservableObject {
    // Array to hold the booked slots
    @Published var bookedSlots: [(date: Date, startTime: Date, endTime: Date, student: String)] = []

    // Function to add a booking
    func bookSlot(date: Date, startTime: Date, endTime: Date, student: String) {
        let newBooking = (date: date, startTime: startTime, endTime: endTime, student: student)
        bookedSlots.append(newBooking)
    }

    // Function to cancel a booking
    func cancelBooking(for slot: Date) {
        if let index = bookedSlots.firstIndex(where: { $0.startTime == slot }) {
            bookedSlots.remove(at: index)
        }
    }

    // Function to check if a slot is already booked
    func isSlotBooked(for date: Date, startTime: Date) -> Bool {
        return bookedSlots.contains { $0.date == date && $0.startTime == startTime }
    }

    // Helper functions to check if the date and time match
    private func isSameDay(_ date1: Date, _ date2: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }

    private func isSameTime(_ date1: Date, _ date2: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.component(.hour, from: date1) == calendar.component(.hour, from: date2) &&
               calendar.component(.minute, from: date1) == calendar.component(.minute, from: date2)
    }
}

struct BookingManager_Previews: PreviewProvider {
    static var previews: some View {
        // Preview to test the BookingManager
        VStack {
            Text("Booking Manager Preview")
                .font(.title)
                .padding()

            // Example usage of BookingManager
            Button("Book Slot") {
                // Example booking
                let manager = BookingManager()
                let date = Date()
                manager.bookSlot(date: date, startTime: date, endTime: date.addingTimeInterval(3600), student: "John Doe")
            }
        }
        .environmentObject(BookingManager())  // Add the BookingManager environment object
        .previewLayout(.sizeThatFits)
    }
}
