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
    
    // Get a reference to the db
    let db = Firestore.firestore()
    
    // Function to delete data from db
    func deleteData(todoToDelete: Todo){
        
        // Specify the document to delete
        db.collection("todos").document(todoToDelete.id).delete { error in
            
            // Check for errors
            if error == nil {
                
                // Update the UI from the main thread
                DispatchQueue.main.async {
                    
                    // Remove the todo that was just deleted
                    self.list.removeAll { todo in
                        // It's going to check each of the todo id from the once that was deleted and if it is a match, remove it from the UI
                        return todo.id == todoToDelete.id
                    }
                }
            }
        }
    }
    
    
    // Function that will add data to the db
    func addData(name: String, notes: String){
        
        // Add document to the collection
        db.collection("todos").addDocument(data: ["name": name, "notes": notes]) { error in
            
            // Check for errors
            if error == nil {
                
                // Call .getData() again to retrieve latest data
                self.getData()
                
            } else {
                // Handle the error
            }
        }
        
    }
    
    // Function that will fetch a data from our db
    func getData(){
        
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
                    DispatchQueue.main.async {
                        // Get all the documents and create Todos
                        self.list = snapshot.documents.map { doc in
                            
                            // Create a Todo item for each document returned
                            return Todo(id: doc.documentID,
                                        // cast these as a String
                                        // if it can't find ["name"] && ["notes"], put an empty string
                                        name: doc["name"] as? String ?? "",
                                        notes: doc["notes"] as? String ?? "")
                        }
                    }

                }
            } else {
                // Handle the error
                print(error?.localizedDescription ?? "")
            }
        }
        
    }
}
