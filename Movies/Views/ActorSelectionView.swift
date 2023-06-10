//
//  ActorSelectionView.swift
//  Movies
//
//  Created by Mohammad Azam on 6/7/23.
//

import SwiftUI
import SwiftData

struct ActorSelectionView: View {
    
    @Query(sort: \.name, order: .forward) private var actors: [Actor]
    @Binding var selectedActors: Set<Actor>
    
    var body: some View {
        List(actors) { actor in
            HStack {
                Image(systemName: selectedActors.contains(actor) ? "checkmark.square" : "square")
                    .onTapGesture {
                        if !selectedActors.contains(actor) {
                            selectedActors.insert(actor)
                        } else {
                            selectedActors.remove(actor)
                        }
                    }
                Text(actor.name)
            }
        }
    }
}


/*
#Preview {
    ActorSelectionView(toggleSelection: { _ in })
        .modelContainer(for: [Actor.self])
} */
