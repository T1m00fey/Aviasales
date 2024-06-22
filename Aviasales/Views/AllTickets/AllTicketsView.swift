//
//  AllTicketsView.swift
//  Aviasales
//
//  Created by Тимофей Юдин on 16.06.2024.
//

import SwiftUI

struct AllTicketsView: View {
    let fromCountry: String
    let toCountry: String
    let day: String
    let month: String
    
    @StateObject private var viewModel = AllTicketsViewModel()
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .foregroundStyle(.blue)
                            .scaleEffect(1.2)
                    }
                    .padding(.leading, 10)
                    .padding(.trailing, 5)
                    
                    VStack {
                        Text("\(fromCountry)-\(toCountry)")
                            .frame(width: 300, alignment: .leading)
                        
                        Text("\(day) \(viewModel.getMonthStr(month)), 1 пассажир")
                            .foregroundStyle(.gray)
                            .frame(width: 300, alignment: .leading)
                    }
                }
                .frame(width: UIScreen.main.bounds.width - 32, height: 60, alignment: .leading)
                .background(Color(uiColor: .systemGray5))
                .padding(.top, 20)
                
                ZStack {
                    ScrollView(showsIndicators: false) {
                        LazyVGrid(columns: [GridItem()], spacing: 5) {
                            ForEach(0..<viewModel.tickets.count, id: \.self) { index in
                                let ticket = viewModel.tickets[index]
                                
                                AllTicketsCellView(
                                    badge: ticket.badge,
                                    price: ticket.price.value,
                                    startTime: viewModel.getTime(byDate: ticket.departure.date),
                                    finishTime: viewModel.getTime(byDate: ticket.arrival.date),
                                    tripTime: viewModel.getTripTime(
                                        startDate: ticket.departure.date,
                                        endDate: ticket.arrival.date
                                    ),
                                    hasTransfer: ticket.hasTransfer,
                                    startAirport: ticket.departure.airport,
                                    finishAirport: ticket.arrival.airport
                                )
                            }
                        }
                    }
                    .padding(.top, 20)
                    
                    filterView
                        .frame(height: UIScreen.main.bounds.height - 250, alignment: .bottom)
                }
            }
        }
        .onAppear {
            if viewModel.tickets.isEmpty {
                viewModel.getTickets()
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    AllTicketsView(fromCountry: "Moscow", toCountry: "Turkey", day: "", month: "")
}

private extension AllTicketsView {
    var filterView: some View {
        HStack(spacing: 20) {
            Button {
                
            } label: {
                HStack {
                    Image(systemName: "slider.horizontal.3")
                    
                    Text("Фильтры")
                        .italic()
                }
            }
            
            Button {
                
            } label: {
                HStack {
                    Image(systemName: "chart.bar.xaxis")
                    
                    Text("График цен")
                        .italic()
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 16)
        .background(.blue)
        .clipShape(Capsule())
    }
}
