//
//  MovieResponse.swift
//  OMBDMoviesApp
//
//  Created by Camilo Ibarra yepes on 2/12/24.
//

import Foundation

struct MovieResponse: Codable {
    let search : [Movie]?
    let totalResults : String?
    let response : String?
    let error: String?

    enum CodingKeys: String, CodingKey {

        case search = "Search"
        case totalResults = "totalResults"
        case response = "Response"
        case error = "Error"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        search = try values.decodeIfPresent([Movie].self, forKey: .search)
        totalResults = try values.decodeIfPresent(String.self, forKey: .totalResults)
        response = try values.decodeIfPresent(String.self, forKey: .response)
        error = try values.decodeIfPresent(String.self, forKey: .error)
    }
    
    var totalPages: Int? {
        guard let totalResults, let totalResultsInt = Int(totalResults) else {
            return nil
        }
        return (totalResultsInt + 9) / 10
    }
}
