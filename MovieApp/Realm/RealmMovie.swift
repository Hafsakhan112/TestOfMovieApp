//
//  RealmMovie.swift
//  MovieApp
//
//  Created by Hafsa Khan on 09/01/2024.
//

import Foundation

import RealmSwift

class RealmMovie: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var releaseDate: String = ""
    @objc dynamic var posterPath: String = ""
    @objc dynamic var adult: Bool = false
    @objc dynamic var backdropPath: String = ""
                  var genres = List<Int>()
    @objc dynamic var id: Int = 0
    @objc dynamic var originalLanguage: String = ""
    @objc dynamic var originalTitle: String = ""
    @objc dynamic var overview: String = ""
    @objc dynamic var popularity: Double = 0
    @objc dynamic var video: Bool = false
    @objc dynamic var voteAverage: Double = 0
    @objc dynamic var voteCount: Int = 0
    @objc dynamic var homepage: String = ""
    // Add other properties as needed
    
    // Define other properties and configurations as needed...

        override static func primaryKey() -> String? {
            return "id"
        }

    // Map from Codable Model to Realm Object
    convenience init(from movie: Movie) {
        self.init()
        self.title = movie.title ?? ""
        self.releaseDate = movie.releaseDate ?? ""
        self.posterPath = movie.posterPath ?? ""
        // Map other properties
    }

    // Map from Realm Object to Codable Model
    func toMovie() -> Movie {
        
        return Movie(adult: adult, backdropPath: backdropPath, genreIds:  Array(genres), id: id, originalLanguage: originalLanguage, originalTitle: originalTitle, overview: overview, popularity: popularity, posterPath: posterPath, releaseDate: releaseDate, title: title, video: video, voteAverage: voteAverage, voteCount: voteCount, homepage: homepage)
        // Return other properties
    }
}

