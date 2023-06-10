//
//  Review.swift
//  Movies
//
//  Created by Mohammad Azam on 6/6/23.
//

import Foundation
import SwiftData

@Model
final class Review {
    var subject: String
    var body: String
    var movie: Movie?
    
    init(subject: String, body: String) {
        self.subject = subject
        self.body = body
    }
}

extension Review {
    
    static var preview: Review {
        Review(subject: "Great movie!", body: "This is a great movie.")
    }
    
}
