//
//  ContentView.swift
//  TodoApp
//
//  Created by Mapletree on 3/14/22.
//

import SwiftUI
import Firebase

// Customize button style
struct AddTodoBtn: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
        .padding(10)
        .buttonStyle(BorderedButtonStyle())
        .background(Color.black)
        .foregroundColor(.white)
        .clipShape(Capsule())
        
    }
}

struct ContentView: View {
    
    // Initialize ViewModel
    @ObservedObject var model = ViewModel()
    
    // Variable to handle name and notes
    @State var name: String = ""
    @State var notes: String = ""
    
    var body: some View {
        
        VStack {
            
            List (model.list){ item in
                HStack {
                    Text(item.name)
                    Spacer()
                    
                    Button {
                        print("hello")
                    } label: {
                        Image(systemName: "pencil")
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    
                    
                    Button {
                        // Delete todo
                        model.deleteData(todoToDelete: item)
                    } label: {
                        Image(systemName: "minus.circle")
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    .foregroundColor(.red)
                }
            }
            
            Divider()
            
            // Add button
            VStack(spacing: 5) {
                // $ -> for binding purposes
                // This textfields will be used for adding data in db
                TextField("Name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Notes", text: $notes)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom)
                
                Button {
                    // Call add data
                    model.addData(name: name, notes: notes)
                    
                    // Clear the text fields
                    name = ""
                    notes = ""
                } label: {
                    Text("Add todo item")
                }
                .buttonStyle(AddTodoBtn())
            } .padding()
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
