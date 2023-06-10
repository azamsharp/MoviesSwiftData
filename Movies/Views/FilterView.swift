//
//  FilterView.swift
//  Movies
//
//  Created by Mohammad Azam on 6/10/23.
//

import SwiftUI
import SwiftData

@Observable
class Criteria {
    var performSearch: Bool = false
    var options: [FilterOption] = []
}

enum FilterOption {
    case name(String)
    case actorsCount(Int)
}


@Observable
class FilterOptions {
    var name: String = ""
    
    init(name: String = "") {
        self.name = name
    }
}

struct FilterView2: View {
    
    @Environment(\.dismiss) private var dismiss
    @Bindable var criteria: Criteria
    @State private var movieName: String = ""
    @State private var numberOfActors: Int?
    
    var body: some View {
        VStack {
            TextField("Movie name", text: $movieName)
                .textFieldStyle(.roundedBorder)
            TextField("Number of actors", value: $numberOfActors, format: .number)
                .keyboardType(.numberPad)
            Button("Search") {
                
                if !movieName.isEmpty {
                    criteria.options.append(.name(movieName))
                }
                
                if numberOfActors != nil {
                    criteria.options.append(.actorsCount(numberOfActors!))
                }
                
                //criteria.options = [.name(movieName)]
                criteria.performSearch = true
                dismiss()
            }
        }
    }
}

struct FilterView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Bindable var filterOptions: FilterOptions
    
    
    var body: some View {
        
        VStack {
            TextField("Movie name", text: $filterOptions.name)
                .textFieldStyle(.roundedBorder)
            Button("Search") {
                dismiss()
            }
        }.padding()
        
    }
}


#Preview {
    FilterView(filterOptions: FilterOptions(name: "Batman"))
}
