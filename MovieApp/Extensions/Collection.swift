//
//  Collection.swift

//
//  Created by Hafsa Khan
//  Copyright © 2020 Hafsa Khan. All rights reserved.
//

import Foundation
extension Collection where Indices.Iterator.Element == Index {
   public subscript(safe index: Index) -> Iterator.Element? {
     return (startIndex <= index && index < endIndex) ? self[index] : nil
   }
}
