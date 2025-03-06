import SwiftUI

struct UserCalendarView: View {
    @EnvironmentObject var bookingManager: BookingManager
    @State private var selectedDate: Date? = nil
    @State private var navigateToTimeSelection = false

    var body: some View {
        VStack {
            Text("Seleziona un giorno")
                .font(.title)
                .bold()
                .padding()

            DatePicker("Mese e anno", selection: Binding(
                get: { selectedDate ?? Date() },
                set: { selectedDate = $0 }
            ), displayedComponents: [.date])
            .datePickerStyle(GraphicalDatePickerStyle())
            .padding()
            .background(Color.blue.opacity(0.1))
            .cornerRadius(8)

            Button(action: {
                if selectedDate != nil {
                    navigateToTimeSelection = true
                }
            }) {
                Text("Seleziona orario")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(selectedDate != nil ? Color.green : Color.gray)
                    .cornerRadius(8)
            }
            .disabled(selectedDate == nil)
            .padding()

            Spacer()
        }
        .padding()
        .navigationDestination(isPresented: $navigateToTimeSelection) {
            if let date = selectedDate {
                TimeSelectionView(selectedDate: date)
                    .environmentObject(bookingManager)
            }
        }
    }
}

struct UserCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        UserCalendarView()
            .environmentObject(BookingManager())
    }
}
