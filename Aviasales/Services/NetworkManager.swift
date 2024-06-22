//
//  NetworkManager.swift
//  Aviasales
//
//  Created by Тимофей Юдин on 31.05.2024.
//

import SwiftUI

enum URLs: String {
    case musicFly = "https://run.mocky.io/v3/ad9a46ba-276c-4a81-88a6-c068e51cce3a"
    case ticketsOffers = "https://run.mocky.io/v3/38b5205d-1a3d-4c2f-9d77-2f9d1ef01a4a"
    case allTickets = "https://run.mocky.io/v3/c0464573-5a13-45c9-89f8-717436748b69"
}

struct Hint: Hashable {
    let background: Color
    let image: String
    let text: String
}

struct Response: Decodable {
    let offers: [MusicFlyOffer]
}

struct MusicFlyOffer: Decodable {
    let id: Int
    let title: String
    let town: String
    let price: Price
}

struct Price: Codable {
    let value: Int
}

struct TicketData: Codable {
    let ticketOffers: [TicketOffer]

    private enum CodingKeys: String, CodingKey {
        case ticketOffers = "tickets_offers"
    }
}

struct TicketOffer: Codable {
    let id: Int
    let title: String
    let timeRange: [String]
    let price: Price

    private enum CodingKeys: String, CodingKey {
        case id, title, timeRange = "time_range", price
    }
}

struct Ticket: Codable {
    let id: Int
    let badge: String?
    let price: Price
    let providerName: String
    let company: String
    let departure: FlightInfo
    let arrival: FlightInfo
    let hasTransfer: Bool
    let hasVisaTransfer: Bool
    let luggage: Luggage
    let handLuggage: HandLuggage
    let isReturnable: Bool
    let isExchangable: Bool
    
    enum CodingKeys: String, CodingKey {
        case id, badge, price, providerName = "provider_name", company, departure, arrival, hasTransfer = "has_transfer", hasVisaTransfer = "has_visa_transfer", luggage, handLuggage = "hand_luggage", isReturnable = "is_returnable", isExchangable = "is_exchangable"
    }
}

struct FlightInfo: Codable {
    let town: String
    let date: String
    let airport: String
}

struct Luggage: Codable {
    let hasLuggage: Bool
    let price: Price?
    
    enum CodingKeys: String, CodingKey {
        case hasLuggage = "has_luggage", price
    }
}

struct HandLuggage: Codable {
    let hasHandLuggage: Bool
    let size: String?
    
    enum CodingKeys: String, CodingKey {
        case hasHandLuggage = "has_hand_luggage", size
    }
}

struct TicketsResponse: Codable {
    let tickets: [Ticket]
}

final class NetworkManager {
    static let shared = NetworkManager()
    private init() { }
    
    func fetchOffers(completion: @escaping ([MusicFlyOffer]?) -> Void) {
        let url = URL(string: URLs.musicFly.rawValue)
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(Response.self, from: data)
                    completion(response.offers)
                } catch {
                    print("Error decoding JSON: \(error)")
                    completion(nil)
                }
            } else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
            }
        }.resume()
    }

    func fetchTicketsData(completion: @escaping ([TicketOffer]?) -> Void) {
        guard let url = URL(string: URLs.ticketsOffers.rawValue) else {
            print("Invalid URL")
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error fetching data: \(error)")
                completion(nil)
                return
            }

            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }

            do {
                let decoder = JSONDecoder()
                let ticketData = try decoder.decode(TicketData.self, from: data)
                completion(ticketData.ticketOffers)
            } catch {
                print("Error decoding data: \(error)")
                completion(nil)
            }
        }.resume()
    }

    func fetchTickets(completion: @escaping ([Ticket]?, Error?) -> Void) {
        guard let url = URL(string: URLs.allTickets.rawValue) else {
            print("Invalid URL")
            completion(nil, URLError(.badURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let tickets = try decoder.decode(TicketsResponse.self, from: data)
                completion(tickets.tickets, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }


}
