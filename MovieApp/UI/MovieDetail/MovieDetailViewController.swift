//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by Hafsa Khan on 08/01/2024.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    
    @IBOutlet weak var imageViewMovie: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var buttonBack: UIButton!
    
    var viewModel = MovieDetailPresenter()
    var movieObj: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let movie = movieObj else { return }
        displayMovieDetails(movie: movie)
    }
    
    private func displayMovieDetails(movie: Movie) {
        if let title = movie.title {
            labelTitle.text = title
        }
        //    titleLabel.text = "\(movie.title ?? "")"
        if let date = movie.releaseDate {
            labelDate.text = formatDate(from: date) ?? ""
        }
        
        // Load poster image using URL or local resource
        imageViewMovie.layer.cornerRadius = 10  // You can adjust the value as per your requirement
        imageViewMovie.layer.masksToBounds = true
        
        if let imagePath = movie.posterPath {
            let baseURL = "https://hungergames.movie" // Adjust size as needed
            if let imageUrl = URL(string: baseURL + (imagePath)) {
                
                // Fetch and set image (You may want to use a library like SDWebImage for caching and loading images asynchronously)
                DispatchQueue.global().async {
                    if let imageData = try? Data(contentsOf: imageUrl) {
                        DispatchQueue.main.async {
                            self.imageViewMovie.image = UIImage(data: imageData)
                        }
                    }
                }
            } else {
                imageViewMovie.image = UIImage(named: "placeholder")
                
            }
        } else {
            // Set a placeholder image or handle the case where no poster path is available
            imageViewMovie.image = UIImage(named: "placeholder")
        }
    }
    
    @IBAction func actionButtonBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

extension MovieDetailViewController {
    
    func formatDate(from dateString: String) -> String? {
        // Create a DateFormatter instance
        let dateFormatter = DateFormatter()
        
        // Set the input format to match the input date string
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        // Convert the input string to a Date object
        if let date = dateFormatter.date(from: dateString) {
            // Update the date format to the desired output format
            dateFormatter.dateFormat = "dd MMM yyyy"
            
            // Convert the Date object back to a string using the desired format
            return dateFormatter.string(from: date)
        }
        
        return "" // Return nil if the conversion fails
    }
}
