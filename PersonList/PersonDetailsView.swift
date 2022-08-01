//
//  PersonDetailsView.swift
//  PersonList
//
//  Created by Jan Andrzejewski on 19/07/2022.
//

import SwiftUI
import MapKit

struct PersonDetailsView: View {
    
    @State var coordinate: CLLocationCoordinate2D
    let deltaSpan = 0.0025
    @StateObject var people = People()
    var person: Person
    
    var body: some View {
        NavigationView {
            VStack {
                Text(person.name)
                    .font(.headline)
                
                person.image ?? Image("testimage")
                
                Map(coordinateRegion: .constant(MKCoordinateRegion(center: .init(latitude: coordinate.latitude, longitude: coordinate.longitude), span: .init(latitudeDelta: deltaSpan, longitudeDelta: deltaSpan))), annotationItems: [person]) { _ in
                        MapAnnotation(coordinate: coordinate) {
                            Circle()
                                .stroke(.primary, lineWidth: 3)
                                .frame(width: 100, height: 100)
                        }
                }
            }
            .navigationTitle("\(person.name)'s details")
        }
    }
}

//struct PersonDetailsView_Previews: PreviewProvider {
    //static var previews: some View {
        //PersonDetailsView(name: "placeholder", image: Image("testimage"), coordinate: CLLocationCoordinate2D(latitude: 37.33233141, longitude: -122.0312186))
    //}
//}
