//
//  MusicFlyingView.swift
//  Aviasales
//
//  Created by Тимофей Юдин on 31.05.2024.
//

import SwiftUI

struct MusicFlyingView: View {
    let musicFlyData: MusicFlyOffer
    
    func getImage(byId id: Int) -> String {
        return "image_id\(id)"
    }
    
    var body: some View {
        VStack {
            Image(getImage(byId: musicFlyData.id))
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .frame(width: 150, height: 150)
            
            Text(musicFlyData.title)
                .frame(width: 150, alignment: .leading)
                .padding(.leading, 10)
                .bold()
                .font(.system(size: 18))
                .foregroundStyle(Color.white)
            
            Text(musicFlyData.town)
                .frame(width: 150, alignment: .leading)
                .font(.system(size: 16))
                .padding(.leading, 10)
                .padding(.top, 1)
                .foregroundStyle(Color.gray)
            
            HStack {
                Image("plane")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 23, height: 23)
                    .foregroundStyle(Color.gray)
                
                Text("от \(musicFlyData.price.value)")
                    .font(.system(size: 16))
                    .foregroundStyle(Color.gray)
            }
            .frame(width: 150, alignment: .leading)
            .padding(.leading, 10)
        }
    }
}

#Preview {
    MusicFlyingView(musicFlyData: MusicFlyOffer(id: 1, title: "", town: "", price: .init(value: 100)))
}
