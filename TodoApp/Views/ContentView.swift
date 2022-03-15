//
//  ContentView.swift
//  TodoApp
//
//  Created by Mapletree on 3/14/22.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    // Initialize ViewModel
    @ObservedObject var model = ViewModel()
    
    // Variable to handle name and notes
    @State var name: String = ""
    @State var notes: String = ""
    
    var body: some View {
        
        VStack {
            List (model.list){ item in
                Text(item.name)
            }
            
            Divider()
            
            // $ -> for binding purposes
            // This textfields will be used for adding data in db
            TextField("Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Notes", text: $notes)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button {
                // Call add data
                model.addData(name: name, notes: notes)
                
                // Clear the text fields
                name = ""
                notes = ""
            } label: {
                Text("Add todo item")
            }

        }
        
    }
    
    // Initialization of this view
    init(){
        model.getData()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()

    }
}
