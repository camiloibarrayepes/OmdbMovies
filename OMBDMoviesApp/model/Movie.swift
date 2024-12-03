//
//  Movie.swift
//  OMBDMoviesApp
//
//  Created by Camilo Ibarra yepes on 2/12/24.
//

import Foundation

struct Movie : Codable, Hashable, Identifiable {
    let id : String?
    let title : String?
    let year : String?
    let type : TypeEnum?
    let poster : String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case id = "imdbID"
        case type = "Type"
        case poster = "Poster"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        year = try values.decodeIfPresent(String.self, forKey: .year)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        
        // Decode the type value and turn into TypeEnum
        if let typeString = try values.decodeIfPresent(String.self, forKey: .type) {
            type = TypeEnum(rawValue: typeString)
        } else {
            type = nil
        }
        poster = try values.decodeIfPresent(String.self, forKey: .poster)
    }

}


enum TypeEnum: String, Codable {
    case movie = "movie"
    case series = "series"
    case game = "game"
    case none = ""
}
