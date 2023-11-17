//
//  JSONManager.swift
//  BookApp
//
//  Created by Armani Chien on 11/16/23.
//

import Foundation

struct Book2: Codable, Identifiable {
    let id = UUID()
    let title: String
    let coverImage: String?
    let author: String
    let tags: [String]
    let description: String
    let availability, borrowedByMe, lendedByMe, wishlistedByMe: Bool

    enum CodingKeys: String, CodingKey {
        case title
        case coverImage = "cover_image"
        case author, tags, description, availability, borrowedByMe, lendedByMe, wishlistedByMe
    }
    
    static let allBooks: [Book2] = Bundle.main.decode(file: "books.json", inDirectory: "Data")
    static let sampleBook: Book2 = allBooks[0]
    
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

