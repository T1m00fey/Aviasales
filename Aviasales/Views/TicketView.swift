//
//  ticketView.swift
//  Aviasales
//
//  Created by Тимофей Юдин on 29.05.2024.
//

import SwiftUI

struct TicketsView: View {
    var body: some View {
        VStack {
            Text("Поиск дешевых авиабилетов")
                .font(.title2)
                .frame(width: 200)
                .multilineTextAlignment(.center)
                .padding()
            
            SearchView()
            
            Spacer()
        }
    }
}

#Preview {
    TicketsView()
}
