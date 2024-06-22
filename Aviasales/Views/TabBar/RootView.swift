//
//  ContentView.swift
//  Aviasales
//
//  Created by Тимофей Юдин on 29.05.2024.
//

import SwiftUI


final class RootViewModel {
    let titles = [
        "Авиабилеты",
        "Отели",
        "Короче",
        "Подписки",
        "Профиль"
    ]
    
    let images = [
        "plane",
        "bed",
        "inShort",
        "bell",
        "profile"
    ]
}

struct RootView: View {
    private var viewModel = RootViewModel()
    
    var body: some View {
        TabView {
            TicketsSearchView()
                .tabItem {
                    Label(
                        title: { Text(viewModel.titles[0]) },
                        icon: { Image(viewModel.images[0]) }
                    )
                }
            
            ForEach(1..<viewModel.titles.count, id: \.self) { index in
                PlugView()
                    .tabItem {
                        Label(
                            title: { Text(viewModel.titles[index]) },
                            icon: {
                                Image(viewModel.images[index])
                            }
                        )
                    }
            }
        }
    }
}

#Preview {
    RootView()
}
