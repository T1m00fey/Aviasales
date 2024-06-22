//
//  TicketsSearchSheetView.swift
//  Aviasales
//
//  Created by Тимофей Юдин on 01.06.2024.
//

import SwiftUI

struct TicketsSearchSheetView: View {
   @StateObject private var viewModel = TicketsSearchSheetViewModel()
    
    @Binding var fromCountry: String
    
    @Binding var toCountry: String
    
    @FocusState var isTF1Focused: Bool
    @FocusState var isTF2Focused: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(uiColor: .systemBackground)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isTF1Focused = false
                        isTF2Focused = false
                    }
                
                VStack {
                    searchView
                        .frame(height: 170)
                    
                    LazyHGrid(rows: [GridItem()], spacing: 0) {
                        ForEach(0..<viewModel.hints.count, id: \.self) { index in
                            let hint = viewModel.hints[index]
                            
                            VStack {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 15)
                                        .foregroundStyle(hint.background)
                                        .frame(width: 60, height: 60)
                                    
                                    Image(hint.image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30, height: 30)
                                        .background(hint.background)
                                }
                                .onTapGesture {
                                    isTF1Focused = false
                                    isTF2Focused = false
                                    
                                    viewModel.isPlugViewSheetPresenting.toggle()
                                }
                                
                                Text(hint.text)
                                    .frame(width: 100, height: 50, alignment: .top)
                                    .multilineTextAlignment(.center)
                                    .font(.system(size: 15))
                            }
                        }
                        .padding(.horizontal, -3)
                    }
                    .frame(height: 80)
                    .padding(.top, 20)
                    .sheet(isPresented: $viewModel.isPlugViewSheetPresenting, content: {
                        PlugView()
                    })
                    
                    List {
                        ForEach(0..<viewModel.countries.count, id: \.self) { index in
                            HStack {
                                Image(viewModel.getImageForCountry(id: index + 1))
                                    .resizable()
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .frame(width: 60, height: 60)
                                
                                VStack(spacing: 10) {
                                    Text(viewModel.countries[index])
                                        .frame(width: 200, alignment: .leading)
                                        .bold()
                                    
                                    Text("Популярное направление")
                                        .font(.system(size: 13))
                                        .foregroundStyle(Color.gray)
                                        .frame(width: 200, alignment: .leading)
                                }
                            }
                            .onTapGesture {
                                viewModel.tfText2 = viewModel.countries[index]
                                toCountry = viewModel.countries[index]
                            }
                        }
                    }
                    .frame(height: 300)
                    
                    Spacer()
                }
            }
        }
        .ignoresSafeArea(.keyboard)
    }
}

#Preview {
    TicketsSearchSheetView(fromCountry: .constant("Moscow"), toCountry: .constant("Москва"))
}

private extension TicketsSearchSheetView {
    var searchView: some View {
        List {
            HStack(spacing: 10) {
                Image("plane2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35, height: 35)
                
                TextField("Откуда - Москва", text: $fromCountry)
                    .focused($isTF1Focused)
            }
            .frame(height: 37)
            
            
            HStack(spacing: 15) {
                Image("search")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                
                HStack {
                    TextField("Куда - Турция", text: $viewModel.tfText2)
                        .focused($isTF2Focused)
                    
                    Button {
                        viewModel.tfText2 = ""
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
            .frame(height: 37)
        }
        .ignoresSafeArea(.keyboard)
        .scrollDisabled(true)
    }
}
