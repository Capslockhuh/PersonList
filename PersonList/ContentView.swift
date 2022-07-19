//
//  ContentView.swift
//  PersonList
//
//  Created by Jan Andrzejewski on 19/07/2022.
//

import SwiftUI

// TODO: save data to disk
// TODO: present images in content view
// TODO: add detail view with a big image

struct ContentView: View {
    @State private var showingAddUser = false
    
    @StateObject var people = People()
    var body: some View {
        NavigationView {
            List {
                ForEach(people.peopleList) { person in
                    Text(person.name)
                }
            }
            .navigationTitle("PersonList")
            .sheet(isPresented: $showingAddUser) {
                AddUserView(people: people)
            }
            .toolbar {
                Button {
                    showingAddUser = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
