//
//  JSONManager.swift
//  BookApp
//
//  Created by Armani Chien on 11/16/23.
//

import Foundation

struct Book2: Codable, Identifiable, Hashable {
    let id = UUID()
    let title: String
    let coverImage: String
    let author: String
    let tags: [String]
    let description: String
    var availability, borrowedByMe, lendedByMe, wishlistedByMe, someoneInterested: Bool

    enum CodingKeys: String, CodingKey {
        case title
        case coverImage = "cover_image"
        case author, tags, description, availability, borrowedByMe, lendedByMe, wishlistedByMe, someoneInterested
    }
    
    static let allBooks: [Book2] = Bundle.main.decode(file: "books.json", inDirectory: "Data")
    
}

struct Person: Codable, Identifiable {
    let id = UUID()
    let name, lastname, bio, favoriteGenre: String
    let profilePicture: String

    enum CodingKeys: String, CodingKey {
        case name, lastname, bio
        case favoriteGenre = "favorite_genre"
        case profilePicture = "profile_picture"
    }
    
    static let allPersons: [Person] = Bundle.main.decode(file: "people.json", inDirectory: "Data")
}

extension Bundle {
    func decode<T: Decodable>(file: String, inDirectory directory: String? = nil) -> T {
        guard let url = self.url(forResource: file, withExtension: nil, subdirectory: directory) else {
            fatalError("Could not find \(file) in the project!")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Could not load \(file) in the project!")
        }
        
        let decoder = JSONDecoder()
        
        guard let loadedData = try? decoder.decode(T.self, from: data) else {
            fatalError("Could not decode \(file) in the project!")
        }
        
        return loadedData
    }
}

