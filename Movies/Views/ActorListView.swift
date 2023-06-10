//
//  ActorListView.swift
//  Movies
//
//  Created by Mohammad Azam on 6/7/23.
//

import SwiftUI

struct ActorListView: View {
    
    let actors: [Actor]
    
    var body: some View {
        List(actors) { actor in
            NavigationLink(value: actor) {
                VStack(alignment: .leading) {
                    Text(actor.name)
                    Text(actor.movies.map { $0.title }, format: .list(type: .and))
                        .font(.caption)
                }
            }
        }.navigationDestination(for: Actor.self) { actor in
            ActorDetailScreen(actor: actor)
        }
    }
}

/*
#Preview {
    ActorListView()
} */
