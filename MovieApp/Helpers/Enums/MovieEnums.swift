//
//  MovieEnums.swift
//  MovieApp
//
//  Created by Hafsa Khan.
//  Copyright © 2020 Hafsa Khan. All rights reserved.
//

import Foundation

enum StoryboardNames: String {
    case home = "Home"
    case movies = "Movies"
    case account = "Account"
    case reusbleComponents = "ReusableComponents"
}

enum ScreenType {
    case login, register, movieDetail, myMovies
}

enum DescriptionStatus {
    case expand, collapse
}

enum NavigationBar {
    case close, search, share, arrowDown, bag, back, phone
}

enum MovieSingleTypeData {
    case sortFilter, productCollection, loadMore
}

