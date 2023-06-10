//
//  FilteredMovieListView.swift
//  Movies
//
//  Created by Mohammad Azam on 6/10/23.
//

import SwiftUI
import SwiftData

struct FilteredMovieListView: View {
    
    @Query private var movies: [Movie]
    
    let criteria: Criteria
    
    //let filterOptions: FilterOptions
    //let name: String
    
    /*
    init(filterOptions: FilterOptions) {
        self.filterOptions = filterOptions
        // THIS LINE CAUSES ISSUES
        //Initializer 'init(_:)' requires that 'FilterOptions' conform to 'Decodable'
        // WHY should it conform to Decodable and Encodable
        _movies = Query(filter: #Predicate { $0.title == filterOptions.name }, sort: \.title, order: .forward)
    } */
    
    
    init(criteria: Criteria) {
        //self.name = name
        self.criteria = criteria
        
        self.criteria.options.forEach { option in
            switch option {
                case .name(let name):
                    _movies = Query(filter: #Predicate { $0.title == name }, sort: \.title, order: .forward)
                case .actorsCount(let noOfActors):
                    _movies = Query(filter: #Predicate { $0.actors.count > noOfActors }, sort: \.title, order: .forward)
            }
        }
        
        //if !name.isEmpty {
         //   _movies = Query(filter: #Predicate { $0.title == name }, sort: \.title, order: .forward)
       // }
    }
    
    var body: some View {
        List(movies) { movie in
            Text(movie.title)
        }
    }
}

/*
#Preview {
    FilteredMovieListView(name: "Batman")
} */
