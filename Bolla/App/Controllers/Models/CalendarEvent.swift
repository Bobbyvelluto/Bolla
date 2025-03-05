import Foundation

struct CalendarEvent: Identifiable {
    let id: String
    let title: String
    let date: Date
    let isAvailable: Bool
    let isBooked: Bool
}
