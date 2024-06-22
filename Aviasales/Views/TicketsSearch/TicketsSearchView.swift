//
//  ticketView.swift
//  Aviasales
//
//  Created by Тимофей Юдин on 29.05.2024.
//

import SwiftUI

struct TicketsSearchView: View {
    @StateObject private var viewModel = TicketsSearchViewModel()
    
    @FocusState private var isTFFocused: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(uiColor: .systemBackground)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isTFFocused = false
                    }
                
                VStack {
                    Text("Поиск дешевых авиабилетов")
                        .font(.title2)
                        .frame(width: 200)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    searchView
                    
                    Text("Музыкально отлететь")
                        .font(.title2)
                        .frame(width: UIScreen.main.bounds.width - 40, alignment: .leadingLastTextBaseline)
                        .padding(.leading, 16)
                        .padding(.top, 16)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            ForEach(0..<viewModel.offers.count, id: \.self) { index in
                                MusicFlyingView(
                                    musicFlyData: MusicFlyOffer(
                                        id: viewModel.offers[index].id,
                                        title: viewModel.offers[index].title,
                                        town: viewModel.offers[index].town,
                                        price: viewModel.offers[index].price
                                    )
                                )
                            }
                        }
                        .padding(.leading, 15)
                    }
                    .frame(width: UIScreen.main.bounds.width, height: 250)
                    
                    Spacer()
                }
                .onAppear {
                    if viewModel.offers.isEmpty {
                        viewModel.fetchOffers()
                    }
                    
                    viewModel.fromCountry = viewModel.getFrom()
                }
                .onDisappear {
                    viewModel.save(from: viewModel.fromCountry)
                }
                .sheet(isPresented: $viewModel.isSearchSheetViewPresenting, content: {
                    TicketsSearchSheetView(fromCountry: $viewModel.fromCountry, toCountry: $viewModel.toCountry)
                })
                .onChange(of: viewModel.toCountry) { oldValue, newValue in
                    if newValue != "" {
                        viewModel.isSearchSheetViewPresenting = false
                        viewModel.isTicketsOffersViewPresenting = true
                    }
                }
                .navigationDestination(isPresented: $viewModel.isTicketsOffersViewPresenting, destination: {
                    TicketsOffersView(fromCountry: $viewModel.fromCountry, toCountry: $viewModel.toCountry)
                })
                .ignoresSafeArea(.keyboard)
            }
        }
    }
}

#Preview {
    TicketsSearchView()
}

private extension TicketsSearchView {
    var searchView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: UIScreen.main.bounds.width - 40, height: 150)
                .foregroundStyle(Color(uiColor: .systemGray5))
            
            HStack(spacing: 0 ) {
                Image("search")
                    .padding(.leading, 10)
                
                List {
                    TextField(
                        "",
                        text: $viewModel.fromCountry,
                        prompt: Text("Откуда - Москва").foregroundStyle(Color(uiColor: .systemGray))
                    )
                    .listRowBackground(Color(uiColor: .systemGray4))
                    .focused($isTFFocused)
                    
                    Button("Куда - Турция") {
                        viewModel.isSearchSheetViewPresenting = true
                        isTFFocused = false
                    }
                    .foregroundStyle(Color(uiColor: .systemGray))
                    .listRowBackground(Color(uiColor: .systemGray4))
                }.environment(\.defaultMinListRowHeight, 35)
                    .offset(y: -15)
                    .scrollContentBackground(.hidden)
                    .scrollDisabled(true)
            }
            .frame(width: UIScreen.main.bounds.width - 80, height: 110)
            .background(Color(uiColor: .systemGray4))
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .shadow(radius: 3)
        }
    }
}
