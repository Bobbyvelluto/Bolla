import EventKit
import Foundation

class CalendarService: ObservableObject {
    private let eventStore = EKEventStore()

    func requestAccess(completion: @escaping (Bool) -> Void) {
        eventStore.requestAccess(to: .event) { granted, error in
            DispatchQueue.main.async {
                completion(granted)
            }
        }
    }

    func fetchEvents(completion: @escaping ([CalendarEvent]) -> Void) {
        let calendars = eventStore.calendars(for: .event)
        let oneMonthAgo = Date().addingTimeInterval(-30 * 24 * 3600)
        let oneMonthFromNow = Date().addingTimeInterval(30 * 24 * 3600)

        let predicate = eventStore.predicateForEvents(withStart: oneMonthAgo, end: oneMonthFromNow, calendars: calendars)
        let ekEvents = eventStore.events(matching: predicate)

        let events = ekEvents.map { ekEvent in
            CalendarEvent(
                id: ekEvent.eventIdentifier,
                title: ekEvent.title,
                date: ekEvent.startDate,
                isAvailable: true, // Modifica in base alla logica
                isBooked: false // Modifica in base alla logica
            )
        }
        completion(events)
    }

    func addEvent(title: String, date: Date, completion: @escaping (Bool) -> Void) {
        let event = EKEvent(eventStore: eventStore)
        event.title = title
        event.startDate = date
        event.endDate = date.addingTimeInterval(3600) // 1 ora di durata
        event.calendar = eventStore.defaultCalendarForNewEvents

        do {
            try eventStore.save(event, span: .thisEvent)
            completion(true)
        } catch {
            print("Errore durante il salvataggio dell'evento: \(error)")
            completion(false)
        }
    }
}
