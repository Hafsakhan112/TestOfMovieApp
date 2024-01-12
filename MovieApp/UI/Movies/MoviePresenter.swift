//
//  MoviePresenter.swift
//  MovieApp
//
//  Created by Hafsa Khan on 29/12/2023.
//

import Foundation
import UIKit
import Moya
import RealmSwift

typealias MovieListingCompletion = (APIResult<[Movie]>, ApiReturnStatus) -> Void

protocol MovieSelectionDelegate: AnyObject {
    func didSelect(movie: Movie)
}

class MoviePresenter: NSObject {
    //private weak var view: MovieListView?
    weak var delegate: MovieSelectionDelegate?

    var data: [Movie] = []
    var isPaginating: Bool = false
    var shouldFetch: Bool = true
    var size = 20
    var isFiltered: Bool = false

    private let movieProvider: MoyaProvider<MovieService> = ServiceProvider.service(.background)

    var moviesResult: [Movie] = []
    private var lastViewedMovie: Movie?
      
   
    var apiKey =         "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhNmNiMWRkZjcwMWVjNTkzZTEwNWE0MzQyNDk3OTI0YSIsInN1YiI6IjY1OGJjZTJiZTIxMDIzMDE0OTFmOTRiZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.TMtJEGiKyvDPfGBN7kYeGkUbqEboMpEB6MvQHcfvlKI"

    
        override init() {

            super.init()
       }
    
    func fetchPopularMovies(completion: @escaping MovieListingCompletion) {
        movieProvider.request(.getMovieList) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self.loadDataFromJSONFile(completion: completion)
                    completion(.failure(error.localizedDescription), .knownFailure)
                }
                
            case .success(let response):
                do {
                    let moviesList: MovieListingModel = try JSONDecoder().decode(MovieListingModel.self, from: response.data)
                    if moviesList.results?.count ?? 0 > 0 {
                        self.data = self.data + (moviesList.results ?? []
                        )
                    }
                    if data.count < self.size {
                        // Handle the case where the number of movies is less than expected
                    }
                                        
                    DispatchQueue.main.async {
                        completion(.success(self.data), .success)
                    }
                    
                } catch {
                    self.isPaginating = false
                    DispatchQueue.main.async {
                        completion(.failure(error.localizedDescription), .unknownFailure)
                    }
                }
            }
        }
    }
    
    func loadDataFromJSONFile(completion: @escaping MovieListingCompletion) {
        if let url = Bundle.main.url(forResource: "MovieList", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                
                let moviesList = try decoder.decode(MovieListingModel.self, from: data)
                // Handle your movies array here
                print(moviesList)
                if moviesList.results?.count ?? 0 > 0 {
                    self.data = self.data + (
                        moviesList.results ?? []
                    )
                }
                DispatchQueue.main.async {
                    completion(.success(self.data), .success)
                }
            } catch {
                // Handle error
                print("Error decoding JSON: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(.failure(error.localizedDescription), .unknownFailure)
                }

            }
        }
    }

}

extension MoviePresenter {
    
    func shouldShowLastViewedMovieDetail() -> Bool {
        return !NetworkMonitor.shared.isConnected
    }
}

extension MoviePresenter {
    
    func movieSelected(at index: Int) {
        let selectedMovie = self.data[index]
            delegate?.didSelect(movie: selectedMovie)
        }
}

// MARK: - Realm Manager

extension MoviePresenter {
    // MARK: - Save Data
        func saveMovieToRealm(movie: RealmMovie) {
            do {
                let realm = try Realm()
                        
                        // Begin write transaction to delete all RealmMovie objects
                try realm.write {
                    realm.delete(realm.objects(RealmMovie.self))
                    print("All RealmMovie objects deleted.")
                  }
                try realm.write {
                    realm.add(movie, update: .modified) // Use .modified if you want to update existing objects
                }
            } catch let error {
                print("Error saving movie: \(error.localizedDescription)")
            }
        }
    
    // MARK: - Retrieve Data
       func retrieveMoviesFromRealm() -> [RealmMovie] {
           let realm = try! Realm() // Use try! for simplicity, handle errors appropriately in a real scenario
           let movies = realm.objects(RealmMovie.self)
           return Array(movies)
       }
    
    // MARK: - Retrieve Data by ID
    func getMovieById(id: Int) -> RealmMovie? {
        let realm = try! Realm() // For simplicity, using try! here. Handle errors appropriately in a real scenario.
        
        // Query to fetch the RealmMovie object by its id
        return realm.object(ofType: RealmMovie.self, forPrimaryKey: id)
    }

    
    func getAllMovies() -> Results<RealmMovie>? {
        do {
            let realm = try Realm()
            return realm.objects(RealmMovie.self)
        } catch let error as NSError {
            print("Error retrieving movies: \(error.localizedDescription)")
            return nil
        }
    }
    
    func getFirstMovie() -> Movie? {
        do {
            var movieObj = Movie(adult: false, backdropPath: "/sRLC052ieEzkQs9dEtPMfFxYkej.jpg", genreIds: [878], id: 848326, originalLanguage: "en", originalTitle: "Rebel Moon - Part One: A Child of Fire", overview: "When a peaceful colony on the edge of the galaxy finds itself threatened by the armies of the tyrannical Regent Balisarius, they dispatch Kora, a young woman with a mysterious past, to seek out warriors from neighboring planets to help them take a stand.", popularity: 2811.615, posterPath: "/ui4DrH1cKk2vkHshcUcGt2lKxCm.jpg", releaseDate: "2023-12-15", title: "Rebel Moon - Part One: A Child of Fire", video: false, voteAverage: 6.479, voteCount: 996, homepage: "")
            let realm = try Realm()
            let realmMovie =  realm.objects(RealmMovie.self).first
            if let movie = realmMovie {
                movieObj.id = movie.id
                movieObj.adult = realmMovie?.adult
                movieObj.backdropPath = realmMovie?.backdropPath
                movieObj.originalLanguage = realmMovie?.originalLanguage
                movieObj.originalTitle = realmMovie?.originalTitle
                movieObj.overview =  realmMovie?.overview
                movieObj.popularity = realmMovie?.popularity
                movieObj.posterPath = realmMovie?.posterPath
                movieObj.releaseDate = realmMovie?.releaseDate
                movieObj.title = realmMovie?.title
                movieObj.video = realmMovie?.video
                movieObj.voteAverage = realmMovie?.voteAverage
                movieObj.voteCount = realmMovie?.voteCount
                movieObj.homepage = realmMovie?.homepage
            }
            
            return movieObj
        } catch let error as NSError {
            print("Error retrieving the first movie: \(error.localizedDescription)")
            return nil
        }
    }
}
