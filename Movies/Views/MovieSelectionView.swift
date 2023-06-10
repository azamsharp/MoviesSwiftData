//
//  MovieSelectionView.swift
//  Movies
//
//  Created by Mohammad Azam on 6/7/23.
//

import SwiftUI
import SwiftData

struct MovieSelectionView: View {
    
    @Query(sort: \.title, order: .forward) private var movies: [Movie]
    @Binding var selectedMovies: Set<Movie> 
    
    var body: some View {
        List(movies) { movie in
            HStack {
                Image(systemName: selectedMovies.contains(movie) ? "checkmark.square": "square")
                    .onTapGesture {
                        if !selectedMovies.contains(movie) {
                            selectedMovies.insert(movie)
                        } else {
                            selectedMovies.remove(movie)
                        }
                    }
                Text(movie.title)
            }
        }
    }
}

/*
#Preview {
    MovieSelectionView()
} */
