//
//  MovieDetailScreen.swift
//  Movies
//
//  Created by Mohammad Azam on 6/6/23.
//

import SwiftUI
import SwiftData

extension NumberFormatter {
    static var year: NumberFormatter {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.groupingSeparator = ""
            return formatter
    }
}

struct MovieDetailScreen: View {
    
    @Environment(\.modelContext) private var context
    let movie: Movie
    
    @State private var title: String = ""
    @State private var year: Int?
    @State private var showReviewScreen: Bool = false
    @State private var actorName: String = ""
    
    private var isFormValid: Bool {
        !title.isEmpty && year != nil
    }
    
    var body: some View {
        Form {
            TextField("Title", text: $title)
            TextField("Year", value: $year, formatter: NumberFormatter.year)
                .keyboardType(.numberPad)
            
            Button("Update") {
                
                guard let year = year else { return }
                
                movie.title = title
                movie.year = year
                
                do {
                    try context.save()
                } catch {
                    print(error.localizedDescription)
                }
                
            }.buttonStyle(.borderless)
                .disabled(!isFormValid)
            
            
            Section("Reviews") {
                Button(action: {
                    showReviewScreen = true
                }, label: {
                    Image(systemName: "plus")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                })
                
                if movie.reviews.isEmpty {
                    ContentUnavailableView {
                        Text("No reviews")
                    }
                } else {
                    ReviewListView(movie: movie)
                }
                
            }
            
            List(movie.actors) { actor in
                ActorCellView(actor: actor)
            }
            
            
            /*
            Section("Actors") {
                HStack {
                    TextField("Actor name", text: $actorName)
                    Button("Save") {
                        let actor = Actor(name: actorName)
                        context.insert(actor)
                        actor.movies.append(movie)
                        movie.actors.append(actor)
                    }
                }
                
                // This DOES refresh after the actor is added to the movie
                //ActorListView(movie: movie)
                
            } */
            
            
        }.onAppear {
            title = movie.title
            year = movie.year
        }
        .sheet(isPresented: $showReviewScreen, content: {
            NavigationStack {
                AddReviewScreen(movie: movie)
            }
        })
       
    }
}


struct MovieDetailContainerScreen: View {
    
    @Environment(\.modelContext) private var context
    @State private var movie: Movie?
    
    var body: some View {
        ZStack {
            if let movie {
                MovieDetailScreen(movie: movie)
            }
        }
            .onAppear {
                movie = Movie(title: "Spiderman", year: 2023)
                context.insert(movie!)
            }
    }
}

#Preview {
    MovieDetailContainerScreen()
        .modelContainer(for: [Movie.self, Review.self])
}
