//
//  PreviewSampleData.swift
//  Movies
//
//  Created by Mohammad Azam on 6/7/23.
//

import Foundation
import SwiftUI
import SwiftData

actor PreviewSampleData {
    @MainActor
    static var container: ModelContainer = {
        let schema = Schema([Movie.self, Review.self])
        let configuration = ModelConfiguration(inMemory: true)
        let container = try! ModelContainer(for: schema, configurations: [configuration])
        let sampleData: [any PersistentModel] = [Movie.preview, Review.preview]
        
        sampleData.forEach {
            container.mainContext.insert($0)
        }
        
        return container 
    }()
}
