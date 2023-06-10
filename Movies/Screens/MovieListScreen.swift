//
//  MovieListScreen.swift
//  Movies
//
//  Created by Mohammad Azam on 6/6/23.
//

import SwiftUI
import SwiftData

enum Sheets: Identifiable {
    case addMovie
    case addActor
    case filter
    
    var id: Int {
        hashValue
    }
}

struct MovieListScreen: View {
    
    @Environment(\.modelContext) private var context
    
    //@Query(filter: #Predicate { $0.year >= 2023 && $0.actors.count > 1 }, sort: \.title, order: .forward) private var movies: [Movie]
    
    //@Query(filter: #Predicate { $0.title.hasPrefix("Bat") == true  }, sort: \.title, order: .forward) private var movies: [Movie]
    
    @Query(sort: \.title, order: .forward) private var movies: [Movie]
    @Query(sort: \.name, order: .forward) private var actors: [Actor]
    
    @State private var activeSheet: Sheets?
    @State private var actorName: String = ""
    @State private var filterOptions: FilterOptions = FilterOptions()
    @State private var criteria: Criteria = Criteria()
    
    private func saveActor() {
        let actor = Actor(name: actorName)
        context.insert(actor)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .firstTextBaseline) {
                Text("Movies")
                    .font(.largeTitle)
                Spacer()
                Button("Filters") {
                    activeSheet = .filter
                }
            }
            
            if movies.isEmpty {
                ContentUnavailableView {
                    Text("No movies available")
                }
            } else {
                //MovieListView(movies: movies)
               // FilteredMovieListView(filterOptions: filterOptions)
                FilteredMovieListView(criteria: criteria)
            }
            
            Text("Actors")
                .font(.largeTitle)
            
            if actors.isEmpty {
                ContentUnavailableView {
                    Text("No actors available")
                }
            } else {
                ActorListView(actors: actors)
            }
            
        }.padding()
            .toolbar(content: {
                
                ToolbarItem(placement: .topBarLeading) {
                    Button("Add Actor") {
                        activeSheet = .addActor
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    
                    Button("Add Movie") {
                        activeSheet = .addMovie
                    }
                }
            })
            .sheet(item: $activeSheet, content: { activeSheet in
                switch activeSheet {
                    case .addMovie:
                        NavigationStack {
                            AddMovieScreen()
                        }
                    case .addActor:
                        Text("Add Actor")
                            .font(.largeTitle)
                        TextField("Actor name", text: $actorName)
                            .textFieldStyle(.roundedBorder)
                            .presentationDetents([.fraction(0.25)])
                            .padding()
                        Button("Save") {
                            self.activeSheet = nil
                            saveActor()
                        }
                    case .filter: VStack {
                        
                        FilterView2(criteria: criteria)
                            .presentationDetents([.medium])
                        //FilterView(filterOptions: filterOptions)
                          //  .presentationDetents([.medium])
                    }
                }
            })
    }
}

#Preview {
    NavigationStack {
        MovieListScreen()
            .modelContainer(for: [Movie.self])
    }
}
