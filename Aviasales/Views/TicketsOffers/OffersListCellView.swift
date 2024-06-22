//
//  OffersListView.swift
//  Aviasales
//
//  Created by Тимофей Юдин on 05.06.2024.
//

import SwiftUI

struct OffersListCellView: View {
    let color: Color
    let airlines: String
    let price: Int
    let times: [String]
    
    @State private var timesText = ""
    
    var body: some View {
        HStack(spacing: 15) {
            Color(color)
                .clipShape(Circle())
                .frame(width: 40, height: 40)
            
            VStack {
                HStack {
                    Text(airlines)
                        .italic()
                    
                    Spacer()
                    
                    HStack {
                        Text("\(price) ₽")
                            .italic()
                            .foregroundStyle(.blue)
                        
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.blue)
                    }
                }
                .frame(width: 268)
                
                Text(timesText)
                    .frame(width: 268, height: 20, alignment: .leading)
            }
        }
        .padding(.horizontal, 16)
        .onAppear {
            for time in times {
                timesText += "\(time)  "
            }
        }
    }
}

#Preview {
    OffersListCellView(color: .red, airlines: "Aeroflot", price: 1000, times: ["19:30", "7:30"])
}
