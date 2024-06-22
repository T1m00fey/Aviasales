//
//  TicketsOffersViewModel.swift
//  Aviasales
//
//  Created by Тимофей Юдин on 21.06.2024.
//

import SwiftUI

@MainActor
final class TicketsOffersViewModel: ObservableObject {
    @Published var fromTFText = ""
    @Published var toTFText = ""
    @Published var ticketOffers: [TicketOffer] = []
    @Published var thereDay = ""
    @Published var thereWeekday = ""
    @Published var thereMonth = ""
    @Published var isThereDatePopoverShowing = false
    @Published var isBackDatePopoverShowing = false
    @Published var thereDate = Date()
    @Published var backDate = Date()
    
    func fetchOffers() {
        NetworkManager.shared.fetchTicketsData { offers in
            if let ticketOffers = offers {
                DispatchQueue.main.async {
                    self.ticketOffers = ticketOffers
                }
            }
        }
    }
    
    func getColor(byId id: Int) -> Color {
        switch id {
        case 0:
            return .red
        case 1:
            return .blue
        default:
            return .white
        }
    }
    
    func getThereDate() {
        let calendar = Calendar.current
        
        let day = calendar.component(.day, from: thereDate)
        let weekday = calendar.component(.weekday, from: thereDate)
        let month = calendar.component(.month, from: thereDate)
        
        thereDay = String(day)
        
        switch weekday {
        case 1:
            thereWeekday = "вс"
        case 2:
            thereWeekday = "пн"
        case 3:
            thereWeekday = "вт"
        case 4:
            thereWeekday = "ср"
        case 5:
            thereWeekday = "чт"
        case 6:
            thereWeekday = "пт"
        default:
            thereWeekday = "сб"
        }
        
        switch month {
        case 1:
            thereMonth = "янв"
        case 2:
            thereMonth = "фев"
        case 3:
            thereMonth = "мар"
        case 4:
            thereMonth = "апр"
        case 5:
            thereMonth = "мая"
        case 6:
            thereMonth = "июня"
        case 7:
            thereMonth = "июля"
        case 8:
            thereMonth = "авг"
        case 9:
            thereMonth = "сен"
        case 10:
            thereMonth = "окт"
        case 11:
            thereMonth = "ноя"
        default:
            thereMonth = "дек"
        }
    }
}
