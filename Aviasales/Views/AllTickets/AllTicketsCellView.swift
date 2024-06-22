//
//  AllTicketsCellView.swift
//  Aviasales
//
//  Created by Тимофей Юдин on 16.06.2024.
//

import SwiftUI

struct AllTicketsCellView: View {
    let badge: String?
    let price: Int
    let startTime: String
    let finishTime: String
    let tripTime: String
    let hasTransfer: Bool
    let startAirport: String
    let finishAirport: String
    
    var body: some View {
        ZStack {
            VStack {
                Text("\(price) ₽")
                    .font(.title2)
                    .frame(width: UIScreen.main.bounds.width - 64, alignment: .leading)
                
                HStack(spacing: 10) {
                    Color(.red)
                        .clipShape(Circle())
                        .frame(width: 30, height: 30)
                    
                    VStack {
                        Text("\(startTime) \(Text("-").foregroundStyle(.gray)) \(finishTime)")
                            .font(.system(size: 15))
                            .italic()
                        
                        HStack(spacing: 25) {
                            Text(startAirport)
                                .foregroundStyle(.gray)
                                .italic()
                            
                            Text(finishAirport)
                                .foregroundStyle(.gray)
                                .italic()
                        }
                    }
                    
                    Text("\(tripTime) ч. в пути\(hasTransfer ? "" : "/Без пересадок")")
                        .font(.system(size: 13))
                        .frame(height: 38, alignment: .top)
                        .offset(x: 7)
                }
                .frame(width: UIScreen.main.bounds.width - 64, alignment: .leading)
            }
            .frame(width: UIScreen.main.bounds.width - 64, height: 100)
            .padding(.horizontal, 16)
            .padding(.vertical, 25)
            .background(Color(uiColor: .secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            if let badge = badge {
                Text(badge)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 15)
                    .background(.blue)
                    .clipShape(Capsule())
                    .italic()
                    .frame(width: UIScreen.main.bounds.width - 32, height: 170, alignment: .topLeading)
                    .padding(.top, 10)
            }
        }
        .frame(height: 170)
    }
}

#Preview {
    AllTicketsCellView(
        badge: "Самый удобный",
        price: 1000,
        startTime: "17:30",
        finishTime: "21:20",
        tripTime: "3.5",
        hasTransfer: false,
        startAirport: "AER",
        finishAirport: "VKO"
    )
}
