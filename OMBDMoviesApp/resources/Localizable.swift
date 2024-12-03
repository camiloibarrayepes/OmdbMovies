//
//  Localizable.swift
//  OMBDMoviesApp
//
//  Created by Camilo Ibarra yepes on 3/12/24.
//

import Foundation


final class Localizable {
    static var bundle: Bundle {
        Bundle(for: Localizable.self)
    }
}

extension Localizable {
    static var table: String { "Localizable" }
    
    static var movieTitle: String {
        NSLocalizedString(
            "APP_TITLE",
            tableName: table,
            bundle: bundle,
            comment: "Title")
    }

    static var searchMovieByName: String {
        NSLocalizedString(
            "SEARCH_A_MOVIE_BY_NAME",
            tableName: table,
            bundle: bundle,
            comment: "Search by name")
    }
    
    static var searchMoviePlaceHolder: String {
        NSLocalizedString(
            "SEARCH_MOVIE_PLACEHOLDER",
            tableName: table,
            bundle: bundle,
            comment: "Search place holder")
    }
    
    static var noDescription: String {
        NSLocalizedString(
            "NO_DESCRIPTION",
            tableName: table,
            bundle: bundle,
            comment: "No description default")
    }
    
    static var year: String {
        NSLocalizedString(
            "YEAR",
            tableName: table,
            bundle: bundle,
            comment: "Year raw value")
    }
    
    static var rating: String {
        NSLocalizedString(
            "RATING",
            tableName: table,
            bundle: bundle,
            comment: "Rating raw value")
    }
}

