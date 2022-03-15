//
//  ViewModel.swift
//  TodoApp
//
//  Created by Mapletree on 3/15/22.
//

import Foundation
import Firebase

class ViewModel: ObservableObject {
    @Published var list = [Todo]() //array of Todo from Models/Todo
    
    // Function that will fetch a data from our db
    func getData(){
        
        // Get a reference to the database
        let db = Firestore.firestore()
        
        // Read the documents at a specific path
        // snapshot -> contains the document in the db
        // error -> contains the error that it might throw fetching document
        db.collection("todos").getDocuments { snapshot, error in
            
            // Check for error
            if error == nil {
                // No errors
                // Get the data
                if let snapshot = snapshot {
                    
                    // Make this task run in the foreground by using DispatchQueue (run in the main thread)
                    // Update the list property in the main thread since it causes UI changes
//                    DispatchQueue.main.async {
//                        // Get all the documents and create Todos
//                        self.list = snapshot.documents.map { doc in
//
//                            // Create a Todo item for each document returned
//                            return Todo(id: doc.documentID,
//                                        // cast these as a String
//                                        // if it can't find ["name"] && ["notes"], put an empty string
//                                        name: doc["name"] as? String ?? "",
//                                        notes: doc["notes"] as? String ?? "")
//                        }
//                    }
                    self.list = snapshot.documents.map { doc in
                        return Todo(id: doc.documentID,
                                    // cast these as a String
                                    // if it can't find ["name"] && ["notes"], put an empty string
                                    name: doc["name"] as? String ?? "",
                                    notes: doc["notes"] as? String ?? "")
                    }
                }
            } else {
                // Handle the error
            }
        }
        
    }
}
