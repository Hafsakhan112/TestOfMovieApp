//
//  MovieService.swift
//  MovieApp
//
//  Created by Hafsa Khan on 29/12/2023.
//

import Foundation
import Moya

enum MovieService {
   case getMovieList
   case getMovieDetail(Int)
    
}

extension MovieService: TargetType {
    
    var sampleData: Data {
        return Data()
    }
    
    var leadingPath: String {
        return "movie/popular"
    }
    
    var baseUrl: String {
        return "https://api.themoviedb.org/3/"
        
    }
    var apiKey: String {
    return
        "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhNmNiMWRkZjcwMWVjNTkzZTEwNWE0MzQyNDk3OTI0YSIsInN1YiI6IjY1OGJjZTJiZTIxMDIzMDE0OTFmOTRiZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.TMtJEGiKyvDPfGBN7kYeGkUbqEboMpEB6MvQHcfvlKI"
    }
    
    
    var task: Task {
        switch self {
          case .getMovieList:
            return .requestParameters(parameters:["api_key": apiKey] , encoding: URLEncoding.init(destination: .queryString))
           // return .requestPlain
        case .getMovieDetail(let movieId):
            return .requestParameters(parameters: ["movie_id": movieId], encoding: URLEncoding.init(destination: .queryString))

        }
        
    }
    
    var baseURL: URL {
        return URL(string: "\(baseUrl)\(leadingPath)?api_key=\(apiKey)")!
    }
    
    var headers: [String : String]? {
        switch self {
        case .getMovieList, .getMovieDetail:
            if apiKey != "" {
                return ["Content-Type": "application/json", "Authorization": "Bearer \(apiKey)"]
            } else {
                return ["Content-Type": "application/json"]
            }
        }
    }
    var path: String {
        switch self {
        case .getMovieList:
            return "\(baseUrl)\(leadingPath)?api_key=\(apiKey)"
        case .getMovieDetail:
            return "\(baseUrl)\(leadingPath)?api_key=\(apiKey)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMovieList, .getMovieDetail:
            return .get
        }
    }

}

