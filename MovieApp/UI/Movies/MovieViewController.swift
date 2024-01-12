//
//  MovieViewController.swift
//  MovieApp
//
//  Created by Hafsa Khan on 28/12/2023.
//

import UIKit


class MovieViewController: UIViewController {
    
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var labelText: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var presenter = MoviePresenter()
    var movies: [Movie] = []
    var filterDataArr = [Movie]()
    private let dispatchGroup = DispatchGroup()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        textField.delegate = self
        presenter.delegate = self
        collectionView.register(UINib.init(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCollectionViewCell")
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !Reachability.isConnectedToNetwork(), let lastViewedMovie = presenter.getFirstMovie() {
            navigateToMovieDetail(movie: lastViewedMovie)
        } else {
            self.fetchData()
        }
    }
    
    private func fetchData(moviesCompletion: (() -> Void)? = nil) {
        fetcMovieshData(moviesCompletion: moviesCompletion)
        
    }
    
    private func fetcMovieshData(moviesCompletion: (() -> Void)? = nil) {
        presenter.fetchPopularMovies { [weak self] (result, status) in
            // Handle result...
            self?.presenter.fetchPopularMovies { [weak self] (result, status) in
                if case .failure(_) = result {
                    
                    
                } else if case .success(_) = result {
                    moviesCompletion?()
                }
                self?.movies = self?.presenter.data ?? [Movie]()
                self?.filterDataArr = self?.movies ?? [Movie]()
                self?.collectionView.reloadData()
            }
        }
    }
}

extension MovieViewController: UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterDataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        let movie = filterDataArr[safe: indexPath.row]
        // Configure cell with movie details
        
        if let unwrappedMovie = movie {
            cell.configure(with: unwrappedMovie)
        } else {
            // Handle the case where movie is nil, if necessary
            print("Movie is nil")
        }
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Return cell size
        return CGSize(width: 180, height: view.frame.height/3.5) // Adjust dimensions as needed
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !presenter.isFiltered {
            presenter.data = self.movies
        } else {
            presenter.data = filterDataArr
        }
        presenter.movieSelected(at: indexPath.row)
    }
    
}


extension MovieViewController: UITextFieldDelegate {
    
    // MARK: - Text Field Search
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let currentText = textField.text as NSString? else { return true }
        let updatedText = currentText.replacingCharacters(in: range, with: string).lowercased()
        labelText.text = ""
        
        if updatedText.count > 0 {
            presenter.isFiltered = true
            self.reload(textField)
        } else {
            presenter.isFiltered = false
            filterDataArr = self.movies
            collectionView.reloadData()
            
        }
        return true
    }
    
    // MARK: - Filter Data
    
    func reload(_ textField: UITextField) {
        if let text = textField.text {
            filterDataArr = self.movies.filter(
                {
                    ($0.title ?? "").lowercased().hasPrefix(text.lowercased()) }).sorted()
            print(filterDataArr)
            presenter.isFiltered = true
            collectionView.reloadData()
        } else {
            presenter.isFiltered = false
        }
    }
}

extension MovieViewController: MovieSelectionDelegate {
    func didSelect(movie: Movie) {
        saveRecentlyViewedInfo(movie: movie)
    }
    
    func navigateToMovieDetail(movie: Movie) {
        if let movieDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController {
            movieDetailVC.movieObj = movie
            navigationController?.pushViewController(movieDetailVC, animated: true)
        }
    }
    
    func saveRecentlyViewedInfo(movie: Movie) {
        let newMovie = RealmMovie()
        newMovie.id = movie.id ?? 0
        newMovie.title = movie.title ?? ""
        newMovie.posterPath = movie.posterPath ?? ""
        newMovie.releaseDate = movie.releaseDate ?? ""
        presenter.saveMovieToRealm(movie: newMovie)
        navigateToMovieDetail(movie: movie)
    }
    
}
