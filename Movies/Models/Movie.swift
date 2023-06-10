//
//  Movie.swift
//  Movies
//
//  Created by Mohammad Azam on 6/6/23.
//

import Foundation
import SwiftData

@Model
final class Movie {
    
    var title: String
    var year: Int
    
    @Relationship(.cascade, inverse: \Review.movie)
    var reviews: [Review] = []
    
    @Relationship(.noAction, inverse: \Actor.movies)
    var actors: [Actor] = []
    
    init(title: String, year: Int) {
        self.title = title
        self.year = year
    }
}

extension Movie {
    
    static var preview: Movie {
        Movie(title: "Batman", year: 2023)
    }
    
}
