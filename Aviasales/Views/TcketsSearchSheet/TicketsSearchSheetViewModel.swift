//
//  TicketsSearchSheetViewModel.swift
//  Aviasales
//
//  Created by Тимофей Юдин on 21.06.2024.
//

import SwiftUI

@MainActor
final class TicketsSearchSheetViewModel: ObservableObject {
    @Published var tfText1 = ""
    @Published var tfText2 = ""
    @Published var isPlugViewSheetPresenting = false
    
    var hints = [
        Hint(background: .green, image: "hardRoute", text: "Сложный маршрут"),
        Hint(background: .cyan, image: "ball", text: "Куда угодно"),
        Hint(background: .blue, image: "calendar", text: "Выходные"),
        Hint(background: .red, image: "fire", text: "Горячие билеты")
    ]
    
    let countries = [
        "Стамбул",
        "Сочи",
        "Пхукет"
    ]
    
    func getImageForCountry(id: Int) -> String {
        return "country_id\(id)"
    }
}
