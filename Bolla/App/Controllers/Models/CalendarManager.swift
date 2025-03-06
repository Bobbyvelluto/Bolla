import UIKit
import EventKit

class CalendarManager {
    static let shared = CalendarManager()
    private let eventStore = EKEventStore()
    
    // Funzione per richiedere il permesso di accesso al calendario
    func requestCalendarPermission(completion: @escaping (Bool) -> Void) {
        eventStore.requestAccess(to: .event) { granted, error in
            if granted {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    // Funzione per aggiungere un evento al calendario
    func addEventToCalendar(title: String, startDate: Date, endDate: Date, location: String) {
        requestCalendarPermission { granted in
            if granted {
                let event = EKEvent(eventStore: self.eventStore)
                event.title = title
                event.startDate = startDate
                event.endDate = endDate
                event.calendar = self.eventStore.defaultCalendarForNewEvents
                event.location = location
                
                do {
                    try self.eventStore.save(event, span: .thisEvent)
                    print("Evento aggiunto al calendario con successo.")
                } catch {
                    print("Errore nell'aggiungere l'evento: \(error.localizedDescription)")
                }
            } else {
                print("Permessi per il calendario non concessi.")
            }
        }
    }
    
    // Funzione per inviare una notifica WhatsApp all'admin
    func sendWhatsAppNotification(student: String, date: Date, startTime: Date, endTime: Date) {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        let formattedDate = formatter.string(from: date)
        let formattedStart = formatter.string(from: startTime)
        let formattedEnd = formatter.string(from: endTime)
        
        let message = "Nuova prenotazione:\nStudente: \(student)\nData: \(formattedDate)\nOrario: \(formattedStart) - \(formattedEnd)"
        
        let phoneNumber = "3355405933" // Numero WhatsApp dell'admin
        let urlStr = "whatsapp://send?phone=\(phoneNumber)&text=\(message)"
        
        if let url = URL(string: urlStr) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                print("WhatsApp non installato")
            }
        }
    }
}
