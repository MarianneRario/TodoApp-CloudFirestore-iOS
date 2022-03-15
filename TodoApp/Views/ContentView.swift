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
    
    var body: some View {
        List (model.list){ item in
            Text(item.name)
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
