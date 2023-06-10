//
//  ActorDetailScreen.swift
//  Movies
//
//  Created by Mohammad Azam on 6/7/23.
//

import SwiftUI

struct ActorDetailScreen: View {
    
    @Environment(\.modelContext) private var context
    
    let actor: Actor
    @State private var selectedMovies: Set<Movie> = []
    
    var body: some View {
        VStack {
            MovieSelectionView(selectedMovies: $selectedMovies)
                .onAppear {
                    selectedMovies = Set(actor.movies)
                }
        }
        .onChange(of: selectedMovies, {
            
            actor.movies = Array(selectedMovies)
            context.insert(actor)
            
        })
        .navigationTitle(actor.name)
    }
}

/*
#Preview {
    ActorDetailScreen()
} */
