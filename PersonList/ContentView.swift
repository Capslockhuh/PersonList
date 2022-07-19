//
//  ContentView.swift
//  PersonList
//
//  Created by Jan Andrzejewski on 19/07/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAddUser = false
    
    @StateObject var people = People()
    var body: some View {
        NavigationView {
            List {
                ForEach(people.peopleList) { person in
                    
                }
            }
            .navigationTitle("PersonList")
            .sheet(isPresented: $showingAddUser) {
                AddUserView()
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
