//
//  TicketsSearchViewModel.swift
//  Aviasales
//
//  Created by Тимофей Юдин on 21.06.2024.
//

import SwiftUI

@MainActor
final class TicketsSearchViewModel: ObservableObject {
    @Published var offers: [MusicFlyOffer] = []
    @Published var isSearchSheetViewPresenting = false
    @Published var toCountry = ""
    @Published var isTicketsOffersViewPresenting = false
    @Published var fromCountry = ""
    
    func fetchOffers() {
        NetworkManager.shared.fetchOffers { offers in
            if let offers = offers {
                DispatchQueue.main.async {
                    self.offers = offers
                }
            }
        }
    }
    
    func save(from: String) {
        StorageManager.shared.save(from: from)
    }
    
    func getFrom() -> String {
        StorageManager.shared.getFrom()
    }
}
