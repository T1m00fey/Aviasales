//
//  TicketsOffersView.swift
//  Aviasales
//
//  Created by Тимофей Юдин on 04.06.2024.
//

import SwiftUI

struct TicketsOffersView: View {
    @Binding var fromCountry: String
    @Binding var toCountry: String
    
    @StateObject private var viewModel = TicketsOffersViewModel()
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                searchView
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: [GridItem(.flexible())]) {
                        Button {
                            viewModel.isBackDatePopoverShowing.toggle()
                        } label: {
                            HStack {
                                Image(systemName: "plus")
                                
                                Text("обратно")
                                    .italic()
                            }
                        }
                        .padding()
                        .background(Color(uiColor: .systemGray4))
                        .clipShape(Capsule())
                        .popover(isPresented: $viewModel.isBackDatePopoverShowing, attachmentAnchor: .point(.bottom), arrowEdge: .top, content: {
                            DatePicker("", selection: $viewModel.backDate)
                                .datePickerStyle(.graphical)
                                .presentationCompactAdaptation(.popover)
                                .frame(minWidth: 300, maxHeight: 500)
                                .padding()
                        })
                                    
                        Button {
                            viewModel.isThereDatePopoverShowing.toggle()
                        } label: {
                            HStack {
                                Text("\(viewModel.thereDay) \(viewModel.thereMonth)\(Text(", \(viewModel.thereWeekday)").foregroundStyle(.gray))")
                                    .italic()
                            }
                        }
                        .padding()
                        .background(Color(uiColor: .systemGray4))
                        .clipShape(Capsule())
                        .popover(isPresented: $viewModel.isThereDatePopoverShowing, attachmentAnchor: .point(.bottom), arrowEdge: .top, content: {
                            DatePicker("", selection: $viewModel.thereDate)
                                .datePickerStyle(.graphical)
                                .presentationCompactAdaptation(.popover)
                                .frame(minWidth: 300, maxHeight: 500)
                                .padding()
                        })
                        
                        HStack {
                            Image(systemName: "person.fill")
                            
                            Text("1, эконом")
                                .italic()
                        }
                        .padding()
                        .background(Color(uiColor: .systemGray4))
                        .clipShape(Capsule())
                        
                        HStack {
                            Image(systemName: "slider.horizontal.3")
                            
                            Text("фильтры")
                                .italic()
                        }
                        .padding()
                        .background(Color(uiColor: .systemGray4))
                        .clipShape(Capsule())
                    }
                    .frame(height: 70)
                    .padding(.leading, 15)
                }
                
                if viewModel.ticketOffers.count >= 3 {
                    List {
                        Section {
                            ForEach(0..<3, id: \.self) { index in
                                OffersListCellView(
                                    color: viewModel.getColor(byId: index),
                                    airlines: viewModel.ticketOffers[index].title,
                                    price: viewModel.ticketOffers[index].price.value,
                                    times: viewModel.ticketOffers[index].timeRange
                                )
                            }
                        } header: {
                            Text("Прямые рейсы")
                        }
                        .headerProminence(.increased)
                    }
                    .scrollContentBackground(.hidden)
                    .scrollDisabled(true)
                    .frame(height: 300)
                }
                
                NavigationLink {
                    AllTicketsView(
                        fromCountry: fromCountry,
                        toCountry: toCountry,
                        day: viewModel.thereDay,
                        month: viewModel.thereMonth
                    )
                } label: {
                    Text("Посмотреть все билеты")
                        .frame(width: UIScreen.main.bounds.width - 64)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .font(.title3)
                        .background(.blue)
                        .italic()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }

                
                Spacer()
            }
            .navigationBarBackButtonHidden()
        }
        .onChange(of: viewModel.thereDate, { oldValue, newValue in
            viewModel.getThereDate()
        })
        .onAppear {
            viewModel.fromTFText = fromCountry
            viewModel.toTFText = toCountry
            
            if viewModel.ticketOffers.isEmpty {
                viewModel.fetchOffers()
            }
            
            if viewModel.thereDay == "" {
                viewModel.getThereDate()
            }
        }
    }
}

#Preview {
    TicketsOffersView(fromCountry: .constant("Moscow"), toCountry: .constant("Turkey"))
}

private extension TicketsOffersView {
    var searchView: some View {
        HStack {
            Image(systemName: "arrow.left")
                .offset(x: 13)
                .scaleEffect(1.3)
                .onTapGesture {
                    dismiss()
                }
            
            List {
                HStack {
                    TextField("Откуда", text: $viewModel.fromTFText)
                    
                    Button {
                        let from = viewModel.fromTFText
                        
                        viewModel.fromTFText = viewModel.toTFText
                        viewModel.toTFText = from
                        
                        fromCountry = viewModel.fromTFText
                        toCountry = viewModel.toTFText
                    } label: {
                        Image(systemName: "arrow.up.arrow.down")
                            .offset(y: -5)
                    }
                }
                .listRowBackground(Color(uiColor: .systemGray4))
                
                HStack {
                    TextField("Куда", text: $viewModel.toTFText)
                    
                    Button {
                        viewModel.toTFText = ""
                        toCountry = ""
                    } label: {
                        Image(systemName: "xmark")
                            .offset(y: 5)
                    }
                }
                .listRowBackground(Color(uiColor: .systemGray4))
            }.environment(\.defaultMinListRowHeight, 35)
                .offset(y: -15)
                .scrollContentBackground(.hidden)
                .scrollDisabled(true)
                .frame(width: UIScreen.main.bounds.width - 60)
        }
        .frame(width: UIScreen.main.bounds.width - 30, height: 110)
        .background(Color(uiColor: .systemGray4))
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}
