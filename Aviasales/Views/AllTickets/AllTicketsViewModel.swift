//
//  AllTicketsViewModel.swift
//  Aviasales
//
//  Created by Тимофей Юдин on 22.06.2024.
//

import Foundation

@MainActor
final class AllTicketsViewModel: ObservableObject {
    @Published var tickets: [Ticket] = []
    
    func getTickets() {
        NetworkManager.shared.fetchTickets { (tickets, error) in
            if let error = error {
                print("Error fetching tickets: \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    self.tickets = tickets ?? []
                }
            }
        }
    }
    
    func getTime(byDate date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

        guard let time = dateFormatter.date(from: date) else { return "None" }
        dateFormatter.dateFormat = "hh:mm"
        
        return dateFormatter.string(from: time)
    }
    
    func getMonthStr(_ month: String) -> String {
        var result = ""
        
        switch month {
        case "янв":
            result = "января"
        case "фев":
            result = "февраля"
        case "мар":
            result = "марта"
        case "апр":
            result = "апреля"
        case "авг":
            result = "августа"
        case "сен":
            result = "сентября"
        case "окт":
            result = "октября"
        case "ноя":
            result = "ноября"
        case "дек":
            result = "декабря"
        default:
            result = month
        }
        
        return result
    }
    
    func getTripTime(startDate: String, endDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

        guard let start = dateFormatter.date(from: startDate) else { return "None" }
        guard let end = dateFormatter.date(from: endDate) else { return "None" }
        
        let result = end.timeIntervalSince(start) / 60 / 60 // разница в часах
        
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        formatter.roundingMode = .up
        
        return formatter.string(from: NSNumber(value: result)) ?? "None"
    }
}
