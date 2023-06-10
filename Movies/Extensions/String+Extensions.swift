//
//  String+Extensions.swift
//  Movies
//
//  Created by Mohammad Azam on 6/6/23.
//

import Foundation

extension String {
    
    var isEmptyOrWhiteSpace: Bool {
        self.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
}
