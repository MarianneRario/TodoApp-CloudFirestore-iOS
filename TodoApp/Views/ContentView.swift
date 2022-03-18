//
//  ContentView.swift
//  TodoApp
//
//  Created by Mapletree on 3/14/22.
//

import SwiftUI
import Firebase

// Customize button style
struct AddTodoBtnDesign: ButtonStyle {
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
    
    var body: some View {
        NavigationView {
            VStack {
                List (model.list){ item in
                    
                    HStack {
                        // Go to the second screen and pass param
                        // model (expected param in 2nd screen): model (local variable here)
                        
                        ZStack(alignment: .leading) {
                            Text(item.name)
                                
                            NavigationLink(destination: NotesView()) {
                                EmptyView()
                                    
                            }
                            
                            .buttonStyle(PlainButtonStyle())
                        }
                        

                        Spacer()
                        
                        Button {
                            print("hello")
                            print(type(of: item.notes))
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
                AddTodoBtn(model: model)
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

struct AddTodoBtn: View {
    
    // Variable to handle name and notes
    @State var name: String = ""
    @State var notes: String = ""
    let model: ViewModel
    
    
    var body: some View {
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
            .buttonStyle(AddTodoBtnDesign())
        } .padding()
        
        // insert navigation properties here
            .navigationTitle("Todo List")
    }
}
