//
//  MovieCollectionViewCell.swift
//  MovieApp
//
//  Created by Hafsa Khan on 28/12/2023.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        posterImageView.layer.cornerRadius = 5  // You can adjust the value as per your requirement
        posterImageView.layer.masksToBounds = true
    }
    
    func configure(with movie: Movie) {
        print(movie)
        if let title = movie.title {
            titleLabel.text = title
        }
        if let date = movie.releaseDate {
            dateLabel.text = formatDate(from: date) ?? ""
        }
        
        // Load poster image using URL or local resource
        //posterImageView.roundedAllCorner()
        posterImageView.layer.cornerRadius = 10  // You can adjust the value as per your requirement
        posterImageView.layer.masksToBounds = true
        
        // posterImageView.layer.masksToBounds = true
        if let imagePath = movie.backdropPath {
            let baseURL = "https://hungergames.movie" // Adjust size as needed
            if let imageUrl = URL(string: baseURL + (imagePath)) {
                
                // Fetch and set image (You may want to use a library like SDWebImage for caching and loading images asynchronously)
                DispatchQueue.global().async {
                    if let imageData = try? Data(contentsOf: imageUrl) {
                        DispatchQueue.main.async {
                            self.posterImageView.image = UIImage(data: imageData)
                        }
                    }
                }
            } else {
                posterImageView.image = UIImage(named: "placeholder")
                
            }
        } else {
            // Set a placeholder image or handle the case where no poster path is available
            posterImageView.image = UIImage(named: "placeholder")
        }
    }
}

extension MovieCollectionViewCell {
    
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

