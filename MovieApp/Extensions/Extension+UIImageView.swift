//
//  Extension+UIImageView.swift
//  MovieApp
//
//  Created by Hafsa Khan on 08/01/2024.
//

import Foundation
import UIKit

extension UIImageView {
    
    func roundedAllCorner(){
        let maskPath1 = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: [.topRight , .bottomRight , .topLeft , .bottomLeft],
                                     cornerRadii: CGSize(width: 15, height: 15))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }
    
    
}
