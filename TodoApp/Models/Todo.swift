//
//  Todo.swift
//  TodoApp
//
//  Created by Mapletree on 3/15/22.
//

import Foundation

// Instance of this struct is going to reproduce a single Todo task
struct Todo: Identifiable {
    
    // We will follow the data structure from the db
    var id: String
    var name: String
    var notes: String
}
