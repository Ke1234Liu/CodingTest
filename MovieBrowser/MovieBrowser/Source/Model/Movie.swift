//
//  Movie.swift
//  MovieBrowser
//
//  Created by Ke Liu on 10/15/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation

struct PageResult: Codable {
    var page: Int
    var totalResults: Int
    var totalPages: Int
    var results: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}

struct Movie: Codable, Equatable {
    var id: Int
    var posterImage: String?
    var title: String
    var rating: Double
    var releaseDate: String?
    var overview: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case releaseDate = "release_date"
        case rating = "vote_average"
        case posterImage = "poster_path"
    }
}
