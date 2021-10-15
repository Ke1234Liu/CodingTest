//
//  NetworkParams.swift
//  MovieBrowser
//
//  Created by Ke Liu on 10/15/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation

enum NetworkParams {
    private struct NetworkConstants {
        static let baseURL = "https://api.themoviedb.org/3/search/movie/"
        static let apiKey = "api_key"
        static let query = "query"
        static let imageBaseURL = "https://image.tmdb.org/t/p/w500/"
    }
        
    case movieSearch(query: String)
    case image(url: String)
    
    var url: URL? {
        switch self {
        case .movieSearch(query: let query):
            var components = URLComponents(string: NetworkConstants.baseURL)
            components?.queryItems = [URLQueryItem(name: NetworkConstants.apiKey, value: "5885c445eab51c7004916b9c0313e2d3"),
                                      URLQueryItem(name: NetworkConstants.query, value: query)]
            return components?.url
        case .image(url: let url):
            return URL(string: "\(NetworkConstants.imageBaseURL)\(url)")
        }
    }
    
}
