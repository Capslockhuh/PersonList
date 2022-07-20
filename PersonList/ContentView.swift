//
//  ContentView.swift
//  PersonList
//
//  Created by Jan Andrzejewski on 19/07/2022.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var showingAddUser = false
    
    @StateObject var people = People()
    var body: some View {
        NavigationView {
            List {
                ForEach(people.peopleList) { person in
                    NavigationLink {
                        PersonDetailsView(coordinate: CLLocationCoordinate2D(latitude: person.latitude ?? 37.33233141, longitude: person.longitude ?? -122.0312186), person: person)
                    } label: {
                        HStack {
                            person.image?
                                .resizable()
                                .scaledToFill()
                                .clipShape(Circle())
                                .frame(width: 44, height: 44)
                            
                            Text(person.name)
                                .font(.subheadline)
                        }
                    }
                }
                .onDelete(perform: removeItems)
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
    
    func removeItems(at offsets: IndexSet) {
        people.peopleList.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
